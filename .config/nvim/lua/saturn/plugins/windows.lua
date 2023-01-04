local M = {
  enabled = true,
  "anuvyklack/windows.nvim",
  event = "WinNew",
  dependencies = {
    { "anuvyklack/middleclass" },
    { "anuvyklack/animation.nvim", enabled = false },
  },
}

function M.init()
  saturn.plugins.whichkey.mappings["w"]["m"] = { "<Cmd>WindowsMaximize<CR>", "Window Maximize" }
  saturn.plugins.whichkey.mappings["w"]["v"] = { "<Cmd>WindowsMaximizeVertically<CR>", "Window Maximize Vertically" }
  saturn.plugins.whichkey.mappings["w"]["h"] =
    { "<Cmd>WindowsMaximizeHorizontally<CR>", "Window Maximize Horizontally" }
  saturn.plugins.whichkey.mappings["w"]["e"] = { "<Cmd>WindowsMaximizeEqualize<CR>", "Window Maximize Equalize" }
end

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
