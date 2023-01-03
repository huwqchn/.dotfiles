local plugin_loader = {}

local utils = require("saturn.utils.helper")
local Log = require("saturn.plugins.log")
local join_paths = utils.join_paths

local plugins_dir = vim.fn.stdpath("data") .. "lazy"

function plugin_loader.init(opts)
  opts = opts or {}

  local install_path = opts.install_path or vim.fn.stdpath("data") .. "lazy/lazy.nvim"

  if not utils.is_directory(install_path) then
    print("Installing first time setup")
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", install_path })
    vim.fn.system({ "git", "-C", install_path, "checkout", "tags/stable" }) -- last stable release
  end
  vim.opt.runtimepath:prepend(install_path)
  vim.opt.runtimepath:prepend(join_paths(plugins_dir, "*"))

  local lazy_cache = require("lazy.core.cache")
  lazy_cache.setup({
    performance = {
      cache = {
        enable = true,
      },
    },
  })
  -- HACK: Don't allow lazy to call setup second time
  lazy_cache.setup = function() end
end

function plugin_loader.reset_cache()
  os.remove(require("lazy.core.cache").config.path)
end

function plugin_loader.reload(spec)
  local lazy_config = require("lazy.core.config")
  local lazy = require("lazy")

  --TODO: reset cache? and unload plugins?
  lazy_config.spec = spec

  require("lazy.core.plugin").load(true)
  require("lazy.core.plugin").update_state()

  local not_installed_plugins = vim.tbl_filter(function(plugin)
    return not plugin._.installed
  end, lazy.config.plugins)

  require("lazy.manage").clear()

  if #not_installed_plugins > 0 then
    lazy.install({ wait = true })
  end

  if #lazy_config.to_clean > 0 then
    -- TODO: set show to true when lazy shows something useful on clean
    lazy.clean({ wait = true, show = false })
  end
end

function plugin_loader.load(configurations)
  Log:debug("loading plugins configuration")
  local lazy_available, lazy = pcall(require, "lazy")
  if not lazy_available then
    Log:warn("skipping loading plugins until lazy.nvim is installed")
    return
  end

  -- remove plugins from rtp before loading lazy, so that all plugins won't be loaded on startup
  vim.opt.runtimepath:remove(join_paths(plugins_dir, "*"))

  local present = xpcall(function()
    local opts = {
      defaults = { lazy = true },
      install = {
        missing = true,
        colorscheme = { saturn.colorscheme, "tokyonight", "habamax" },
      },
      ui = {
        border = "rounded",
      },
      root = plugins_dir,
      git = {
        timeout = 120,
      },
      performance = {
        rtp = {
          reset = false,
        },
      },
    }

    lazy.setup(configurations, opts)
  end, debug.traceback)

  if not present then
    Log:warn("problems detected while loading plugins' configurations")
    Log:trace(debug.traceback())
  end
end

function plugin_loader.get_core_plugins()
  local names = {}
  local plugins = require("saturn.plugins").get()
  local get_name = require("lazy.core.plugin").Spec.get_name
  for _, spec in pairs(plugins) do
    if spec.enabled == true or spec.enabled == nil then
      table.insert(names, get_name(spec[1]))
    end
  end
  return names
end

function plugin_loader.sync_core_plugins()
  local core_plugins = plugin_loader.get_core_plugins()
  Log:trace(string.format("Syncing core plugins: [%q]", table.concat(core_plugins, ", ")))
  require("lazy").sync({ wait = true, plugins = core_plugins })
end

function plugin_loader.ensure_plugins()
  Log:debug("calling lazy.install()")
  require("lazy").install({ wait = true })
end

return plugin_loader
