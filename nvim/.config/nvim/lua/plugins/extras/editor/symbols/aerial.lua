return {
  {
    "stevearc/aerial.nvim",
    optional = true,
    opts = {
      min_width = 20,
      keymaps = {
        ["<C-e>"] = "actions.down_and_scroll",
        ["<C-i>"] = "actions.up_and_scroll",
        ["l"] = "actions.tree_toggle",
        ["L"] = "actions.tree_toggle_recursive",
        ["o"] = "actions.tree_open",
        ["O"] = "actions.tree_open_recursive",
        ["n"] = "actions.tree_close",
        ["N"] = "actions.tree_close_recursive",
      },
    },
  },
}
