local M = {}

function M.init()
  local init_opts = require("saturn.plugins.core.configs.packer")
  local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

  if vim.fn.empty(vim.fn.glob(installLpath)) > 0 then
    vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
    vim.cmd "packadd packer.nvim"
  end
  local status_ok, packer = pcall(require, "packer")
  if status_ok then
    packer.on_complete = vim.schedule_wrap(function()
      packer.clean()
      packer.sync()
      vim.g.colors_name = saturn.colorscheme
      pcall(vim.cmd, "colorscheme " .. saturn.colorscheme)
    end)
    packer.init(init_opts)
  end
end

function M.load(configs)
  local status_ok, packer = pcall(require, "packer")
  if not status_ok then
    return
  end
  status_ok, _ = xpcall(function()
    packer.reset()
    packer.startup(function(use)
      for _, plugins in ipairs(configs) do
        for _, plugin in ipairs(plugins) do
          use(plugin)
        end
      end
    end)
  end, debug.traceback)
  
  if not status_ok then
    print(debug.traceback())
  end
end

return M
