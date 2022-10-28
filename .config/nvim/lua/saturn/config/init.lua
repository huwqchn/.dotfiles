local utils = require "saturn.utils"
local Log = require "saturn.core.log"

local M = {}
local user_config_dir = get_config_dir()
local user_config_file = utils.join_paths(user_config_dir, "config.lua")

---Get the full path to the user configuration file
---@return string
function M:get_user_config_path()
  return user_config_file
end

--- Initialize saturn default configuration and variables
function M:init()
  saturn = vim.deepcopy(require "saturn.config.settings")

  require("saturn.config.keymappings").load_colemak()

  local builtins = require "saturn.core.builtins"
  builtins.config { user_config_file = user_config_file }

  local settings = require "saturn.config.options"
  settings.load_defaults()

  local autocmds = require "saturn.core.autocmds"
  autocmds.load_defaults()

  local saturn_lsp_config = require "saturn.lsp.config"
  saturn.lsp = vim.deepcopy(saturn_lsp_config)

  ---@deprecated replaced with saturn.builtin.alpha
  saturn.builtin.dashboard = {
    active = false,
    on_config_done = nil,
    search_handler = "",
    disable_at_vim_enter = 0,
    session_directory = "",
    custom_header = {},
    custom_section = {},
    footer = {},
  }

  saturn.builtin.luasnip = {
    sources = {
      friendly_snippets = true,
    },
  }

  ---@deprecated
  saturn.builtin.notify = {
    active = false
  }
end

local function handle_deprecated_settings()
  local function deprecation_notice(setting, new_setting)
    local in_headless = #vim.api.nvim_list_uis() == 0
    if in_headless then
      return
    end

    local msg = string.format(
      "Deprecation notice: [%s] setting is no longer supported. %s",
      setting,
      new_setting or "See https://github.com/LunarVim/LunarVim#breaking-changes"
    )
    vim.schedule(function()
      vim.notify_once(msg, vim.log.levels.WARN)
    end)
  end

  ---saturn.lang.FOO.lsp
  for lang, entry in pairs(saturn.lang) do
    local deprecated_config = entry.formatters or entry.linters or {}
    if not vim.tbl_isempty(deprecated_config) then
      deprecation_notice(string.format("saturn.lang.%s", lang))
    end
  end

  -- saturn.lsp.override
  if saturn.lsp.override and not vim.tbl_isempty(saturn.lsp.override) then
    deprecation_notice("saturn.lsp.override", "Use `saturn.lsp.automatic_configuration.skipped_servers` instead")
    vim.tbl_map(function(c)
      if not vim.tbl_contains(saturn.lsp.automatic_configuration.skipped_servers, c) then
        table.insert(saturn.lsp.automatic_configuration.skipped_servers, c)
      end
    end, saturn.lsp.override)
  end

  -- saturn.lsp.popup_border
  if vim.tbl_contains(vim.tbl_keys(saturn.lsp), "popup_border") then
    deprecation_notice "saturn.lsp.popup_border"
  end

  -- dashboard.nvim
  if saturn.builtin.dashboard.active then
    deprecation_notice("saturn.builtin.dashboard", "Use `saturn.builtin.alpha` instead. See LunarVim#1906")
  end


  -- notify.nvim
  if saturn.builtin.notify.active then
    deprecation_notice("saturn.builtin.notify", "See LunarVim#3294")
  end


  if saturn.autocommands.custom_groups then
    deprecation_notice(
      "saturn.autocommands.custom_groups",
      "Use vim.api.nvim_create_autocmd instead or check LunarVim#2592 to learn about the new syntax"
    )
  end

  if saturn.lsp.automatic_servers_installation then
    deprecation_notice(
      "saturn.lsp.automatic_servers_installation",
      "Use `saturn.lsp.installer.setup.automatic_installation` instead"
    )
  end
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:load(config_path)
  local autocmds = reload "saturn.core.autocmds"
  config_path = config_path or self:get_user_config_path()
  local ok, err = pcall(dofile, config_path)
  if not ok then
    if utils.is_file(user_config_file) then
      Log:warn("Invalid configuration: " .. err)
    else
      vim.notify_once(
        string.format("User-configuration not found. Creating an example configuration in %s", config_path)
      )
      local example_config = join_paths(get_saturn_base_dir(), "utils", "installer", "config.example.lua")
      vim.loop.fs_copyfile(example_config, config_path)
    end
  end

  Log:set_level(saturn.log.level)

  handle_deprecated_settings()

  autocmds.define_autocmds(saturn.autocommands)

  vim.g.mapleader = (saturn.leader == "space" and " ") or saturn.leader

  reload("saturn.config.keymappings").load(saturn.keys)

  if saturn.transparent_window then
    autocmds.enable_transparent_mode()
  end

  if saturn.reload_config_on_save then
    autocmds.enable_reload_config_on_save()
  end
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:reload()
  vim.schedule(function()
    reload("saturn.utils.hooks").run_pre_reload()

    M:load()

    reload("saturn.core.autocmds").configure_format_on_save()

    local plugins = reload "saturn.plugins"
    local plugin_loader = reload "saturn.plugin-loader"

    plugin_loader.reload { plugins, saturn.plugins }
    reload("saturn.core.theme").setup()
    reload("saturn.utils.hooks").run_post_reload()
  end)
end

return M
