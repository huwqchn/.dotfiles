return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    keys = {
      {
        "<leader>be",
        "<cmd>Neotree float buffers<cr>",
        desc = "Explorer buffers",
      },
      {
        "<leader>ge",
        "<cmd>Neotree float git_status<cr>",
        desc = "Explorer git status",
      },
    },
    opts = {
      close_if_last_window = true,
      filesystem = {
        window = {
          mappings = {
            ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "O" } },
            ["Oc"] = { "order_by_created", nowait = false },
            ["Od"] = { "order_by_diagnostics", nowait = false },
            ["Og"] = { "order_by_git_status", nowait = false },
            ["Om"] = { "order_by_modified", nowait = false },
            ["On"] = { "order_by_name", nowait = false },
            ["Os"] = { "order_by_size", nowait = false },
            ["Ot"] = { "order_by_type", nowait = false },
            ["o"] = "none",
            ["oc"] = "none",
            ["od"] = "none",
            ["og"] = "none",
            ["om"] = "none",
            ["on"] = "none",
            ["os"] = "none",
            ["ot"] = "none",
          },
        },
      },
      buffers = {
        window = {
          mappings = {
            ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "O" } },
            ["Oc"] = { "order_by_created", nowait = false },
            ["Od"] = { "order_by_diagnostics", nowait = false },
            ["Om"] = { "order_by_modified", nowait = false },
            ["On"] = { "order_by_name", nowait = false },
            ["Os"] = { "order_by_size", nowait = false },
            ["Ot"] = { "order_by_type", nowait = false },
            ["o"] = "none",
            ["oc"] = "none",
            ["od"] = "none",
            ["om"] = "none",
            ["on"] = "none",
            ["os"] = "none",
            ["ot"] = "none",
          },
        },
      },
      git_status = {
        window = {
          mappings = {
            ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "O" } },
            ["Oc"] = { "order_by_created", nowait = false },
            ["Od"] = { "order_by_diagnostics", nowait = false },
            ["Om"] = { "order_by_modified", nowait = false },
            ["On"] = { "order_by_name", nowait = false },
            ["Os"] = { "order_by_size", nowait = false },
            ["Ot"] = { "order_by_type", nowait = false },
            ["o"] = "none",
            ["oc"] = "none",
            ["od"] = "none",
            ["om"] = "none",
            ["on"] = "none",
            ["os"] = "none",
            ["ot"] = "none",
          },
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
          ["I"] = "show_file_details",
          ["i"] = "none",
          -- ["w"] = "open",
        },
      },
    },
  },
}
