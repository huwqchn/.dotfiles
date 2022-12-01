local plugin_loader = {}

local utils = require("saturn.utils.helper")
local Log = require "saturn.plugins.log"
local in_headless = #vim.api.nvim_list_uis() == 0


local compile_path = vim.fn.stdpath "config" .. "/plugin/packer_compile.lua"
local snapshot_path = vim.fn.stdpath "cache" .. "/snapshots"

function plugin_loader.init(opts)
  opts = opts or {}

  local install_path = opts.install_path or vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
  local max_jobs = 100
  if vim.fn.has "mac" == 1 then
    max_jobs = 50
  end

  local init_opts = {
    package_root = opts.package_root or vim.fn.stdpath "data" .. "/site/pack",
    compile_path = compile_path,
    snapshot_path = snapshot_path,
    max_jobs = max_jobs,
    log = { level = "warn" },
    git = {
      clone_timeout = 120,
    },
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  if in_headless then
    init_opts.display = nil
    init_opts.git.clone_timeout = 300
  end

  if not utils.is_directory(install_path) then
    print "Installing first time setup"
    print "Installing packer..."
    print(vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd [[packadd packer.nvim]]
  end
  local present, packer = pcall(require, "packer")
  if present then
    packer.on_complete = vim.schedule_wrap(function()
      require("saturn.utils.hooks").run_on_packer_complete()
    end)
    packer.init(init_opts)
  end
end

-- packer expects a space separated list
local function pcall_packer_command(cmd, kwargs)
  local present, msg = pcall(function()
    require("packer")[cmd](unpack(kwargs or {}))
  end)
  if not present then
    Log:warn(cmd .. " failed with: " .. vim.inspect(msg))
    Log:trace(vim.inspect(vim.fn.eval "v:errmsg"))
  end
end

function plugin_loader.cache_clear()
  if not utils.is_file(compile_path) then
    return
  end
  if vim.fn.delete(compile_path) == 0 then
    Log:debug "deleted packer_compiled.lua"
  end
end

function plugin_loader.compile()
  Log:debug "calling packer.compile()"
  vim.api.nvim_create_autocmd("User", {
    pattern = "PackerCompileDone",
    once = true,
    callback = function()
      if utils.is_file(compile_path) then
        Log:debug "finished compiling packer_compiled.lua"
      end
    end
  })
  pcall_packer_command "compile"
end

function plugin_loader.recompile()
  plugin_loader.cache_clear()
  plugin_loader.compile()
end

function plugin_loader.reload(configurations)
  _G.packer_plugins = _G.packer_plugins or {}
  for k, v in pairs(_G.packer_plugins) do
    if k ~= "packer.nvim" then
      _G.packer_plugins[v] = nil
    end
  end
  plugin_loader.load(configurations)

  plugin_loader.ensure_plugins()
end

function plugin_loader.load(configurations)
  Log:debug "loading plugins configuration"
  local packer_available, packer = pcall(require, "packer")
  if not packer_available then
    Log:warn "skipping loading plugins until Packer is installed"
    return
  end
  local present, _ = xpcall(function()
    packer.reset()
    packer.startup(function(use)
      for _, plugins in ipairs(configurations) do
        for _, plugin in ipairs(plugins) do
          use(plugin)
        end
      end
    end)
  end, debug.traceback)

  if not present then
    Log:warn "problems detected while loading plugins' configurations"
    Log:trace(debug.traceback())
  end
end

function plugin_loader.get_core_plugins()
  local list = {}
  local plugins = require("saturn.plugins.core").get()
  for _, item in pairs(plugins) do
    if not item.disable then
      table.insert(list. item[1]:match "/(%S*)")
    end
  end
  return list
end

function plugin_loader.load_snapshot(snapshot_file)
  if not in_headless then
    vim.notify("Syncing core plugins is in progress..", vim.log.levels.INFO, { title = "lvim" })
  end
  Log:debug(string.format("Using snapshot file [%s]", snapshot_file))
  local core_plugins = plugin_loader.get_core_plugins()
  require("packer").rollback(snapshot_file, unpack(core_plugins))
end

function plugin_loader.sync_core_plugins()
  plugin_loader.cache_clear()
  local core_plugins = plugin_loader.get_core_plugins()
  Log:trace(string.format("Syncing core plugins: [%q]", table.concat(core_plugins, ", ")))
  pcall_packer_command("sync", core_plugins)
end

function plugin_loader.ensure_plugins()
  vim.api.nvim_create_autocmd("User", {
    pattern = "PackerComplete",
    once = true,
    callback = function()
      plugin_loader.compile()
    end,
  })
  Log:debug "calling packer.install()"
  pcall_packer_command "install"
end

return plugin_loader
