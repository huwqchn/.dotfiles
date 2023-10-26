return {
  -- harpoon
  {
    "christianchiarulli/harpoon",
    keys = {
      { "]m", '<cmd>lua require("harpoon.ui").nav_next()<cr>', desc = "Next Mark File" },
      { "[m", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', desc = "Prev Mark File" },
      { "<leader>f'", "<cmd>Telescope harpoon marks<cr>", desc = "Search Mark Files" },
      { "<leader>m;", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = "Harpoon UI" },
      { "<leader>mm", '<cmd>lua require("harpoon.mark").add_file()<cr>', desc = "Harpoon" },
    },
    config = true,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>m"] = { name = "+marks" },
      },
    },
  },
}
