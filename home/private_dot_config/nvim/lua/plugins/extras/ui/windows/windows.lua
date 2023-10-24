return {
  {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    keys = {
      { "<leader>wz", "<Cmd>WindowsMaximize<CR>", desc = "Zoom" },
      { "sz", "<leader>wz", remap = true, desc = "Zoom window" },
      { "<leader>wv", "<Cmd>WindowsMaximizeVertically<CR>", desc = "Maximize Vertically" },
      { "<leader>wh", "<Cmd>WindowsMaximizeHorizontally<CR>", desc = "Maximize Horizontally" },
      { "<leader>wb", "<Cmd>WindowsEqualize<CR>", desc = "Balance" },
      { "sb", "<leader>wb", remap = true, desc = "Balance window" },
    },
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim", enabled = false },
    },
    config = function()
      vim.o.winwidth = 5
      vim.o.equalalways = false
      require("windows").setup({
        animation = { enable = false, duration = 150 },
      })
    end,
  },
}
