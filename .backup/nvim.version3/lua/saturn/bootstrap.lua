local M = {}

if vim.fn.has "nvim-0.8" ~= 1 then
  vim.notify("Please upgrade your Neovim base installation. Lunarvim requires v0.8+", vim.log.levels.WARN)
  vim.wait(5000, function()
    return false
  end)
  vim.cmd "cquit"
end

local uv = vim.loop
local path_sep = uv.os_uname().version:match "Windows" and "\\" or "/"

---Join path segments that were passed as input
---@return string
function _G.join_paths(...)
  local result = table.concat({ ... }, path_sep)
  return result
end

_G.require_clean = require("saturn.utils.modules").require_clean
_G.require_safe = require("saturn.utils.modules").require_safe
_G.reload = require("saturn.utils.modules").reload

---Get the full path to `$LUNARVIM_RUNTIME_DIR`
---@return string
function _G.get_runtime_dir()
  local saturn_runtime_dir = os.getenv "LUNARVIM_RUNTIME_DIR"
  if not saturn_runtime_dir then
    -- when nvim is used directly
    return vim.call("stdpath", "data")
  end
  return saturn_runtime_dir
end

---Get the full path to `$LUNARVIM_CONFIG_DIR`
---@return string
function _G.get_config_dir()
  local saturn_config_dir = os.getenv "LUNARVIM_CONFIG_DIR"
  if not saturn_config_dir then
    return vim.call("stdpath", "config")
  end
  return saturn_config_dir
end

---Get the full path to `$LUNARVIM_CACHE_DIR`
---@return string
function _G.get_cache_dir()
  local saturn_cache_dir = os.getenv "LUNARVIM_CACHE_DIR"
  if not saturn_cache_dir then
    return vim.call("stdpath", "cache")
  end
  return saturn_cache_dir
end

---Initialize the `&runtimepath` variables and prepare for startup
---@return table
function M:init(base_dir)
  self.runtime_dir = get_runtime_dir()
  self.config_dir = get_config_dir()
  self.cache_dir = get_cache_dir()
  self.pack_dir = join_paths(self.runtime_dir, "site", "pack")
  self.packer_install_dir = join_paths(self.runtime_dir, "site", "pack", "packer", "start", "packer.nvim")
  self.packer_cache_path = join_paths(self.config_dir, "plugin", "packer_compiled.lua")

  ---@meta overridden to use LUNARVIM_CACHE_DIR instead, since a lot of plugins call this function internally
  ---NOTE: changes to "data" are currently unstable, see #2507
  vim.fn.stdpath = function(what)
    if what == "cache" then
      return _G.get_cache_dir()
    end
    return vim.call("stdpath", what)
  end

  ---Get the full path to LunarVim's base directory
  ---@return string
  function _G.get_saturn_base_dir()
    return base_dir
  end

  if os.getenv "LUNARVIM_RUNTIME_DIR" then
    -- vim.opt.rtp:append(os.getenv "LUNARVIM_RUNTIME_DIR" .. path_sep .. "saturn")
    vim.opt.rtp:remove(join_paths(vim.call("stdpath", "data"), "site"))
    vim.opt.rtp:remove(join_paths(vim.call("stdpath", "data"), "site", "after"))
    vim.opt.rtp:prepend(join_paths(self.runtime_dir, "site"))
    vim.opt.rtp:append(join_paths(self.runtime_dir, "saturn", "after"))
    vim.opt.rtp:append(join_paths(self.runtime_dir, "site", "after"))

    vim.opt.rtp:remove(vim.call("stdpath", "config"))
    vim.opt.rtp:remove(join_paths(vim.call("stdpath", "config"), "after"))
    vim.opt.rtp:prepend(self.config_dir)
    vim.opt.rtp:append(join_paths(self.config_dir, "after"))
    -- TODO: we need something like this: vim.opt.packpath = vim.opt.rtp

    vim.cmd [[let &packpath = &runtimepath]]
  end

  if not vim.env.saturn_TEST_ENV then
    require "saturn.impatient"
  end

  require("saturn.config"):init()

  require("saturn.plugin-loader").init {
    package_root = self.pack_dir,
    install_path = self.packer_install_dir,
  }

  return self
end

---Update LunarVim
---pulls the latest changes from github and, resets the startup cache
function M:update()
  reload("saturn.utils.hooks").run_pre_update()
  local ret = reload("saturn.utils.git").update_base_saturn()
  if ret then
    reload("saturn.utils.hooks").run_post_update()
  end
end

return M
