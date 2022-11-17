local M = {}

function M.config()
  saturn.plugins.crates = {
    active = true,
    on_config_done = nil,
    popup = {
      -- autofocus = true,
      style = "minimal",
      border = "rounded",
      show_version_date = false,
      show_dependency_version = true,
      max_height = 30,
      min_width = 20,
      padding = 1,
    },
    null_ls = {
      enabled = true,
      name = "crates.nvim",
    },
  }
end

function M.setup()
  local status_ok, crates = pcall(require, "crates")
  if not status_ok then
    return
  end
  crates.setup(saturn.plugins.crates)
  if saturn.plugins.crates.on_config_done then
    saturn.plugins.crates.on_config_done(crates)
  end
end

return M
