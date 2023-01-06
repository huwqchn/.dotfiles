local M = {
  enabled = true,
  "anuvyklack/windows.nvim",
  event = "WinNew",
  dependencies = {
    { "anuvyklack/middleclass" },
    { "anuvyklack/animation.nvim", enabled = false },
  },
  keys = {
    { "<leader>wm", "<Cmd>WindowsMaximize<CR>", desc = "Window Maximize" },
    { "<leader>wv", "<Cmd>WindowsMaximizeVertically<CR>", desc = "Window Maximize Vertically" },
    { "<leader>wh", "<Cmd>WindowsMaximizeHorizontally<CR>", desc = "Window Maximize Horizontally" },
    { "<leader>we", "<Cmd>WindowsEqualize<CR>", desc = "Window Maximize Equalize" },
  },
  cmd = {
    "WindowsMaximize",
    "WindowsMaximizeVertically",
    "WindowsMaximizeHorizontally",
    "WindowsEqualize",
    "WindowsEnableAutowidth",
    "WindowsDisableAutowidth",
    "WindowsToggleAutowidth",
  },
}

function M.config()
  vim.o.winwidth = 5
  vim.o.winminwidth = 5
  vim.o.equalalways = false
  require("windows").setup({
    animation = {
      enable = false,
      duration = 150,
    },
  })
end

return M
