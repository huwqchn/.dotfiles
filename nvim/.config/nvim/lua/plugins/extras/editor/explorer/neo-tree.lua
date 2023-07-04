return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          hide_dofiles = true,
        },
      },
      window = {
        -- width = 30,
        mappings = {
          -- ["<cr>"] = "open_with_window_picker",
          ["e"] = "none",
          ["E"] = "toggle_auto_expand_width",
          ["N"] = {
            "toggle_node",
            nowait = false,
          },
          -- ["w"] = "open",
        },
      },
    },
  },
}
