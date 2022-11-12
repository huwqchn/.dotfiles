local M = {}

function M.config()
  saturn.plugins.copilot = {
    cmp = {
      enabled = true,
      method = "getCompletionsCycling",
    },
    panel = { -- no config options yet
      enabled = true,
    },
    ft_disable = { "markdown" },
    -- plugin_manager_path = vim.fn.stdpath "data" .. "/site/pack/packer",
    server_opts_overrides = {
      -- trace = "verbose",
      settings = {
        advanced = {
          -- listCount = 10, -- #completions for panel
          inlineSuggestCount = 3, -- #completions for getCompletions
        },
      },
    },
  }
end

function M.setup()
  local present, copilot = pcall(require, "copilot")
  if not present then
    return
  end

  copilot.setup(saturn.plugins.copilot)
end

return M
