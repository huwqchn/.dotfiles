return {
  {
    import = "lazyvim.plugins.extras.ai.copilot",
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    optional = true,
    keys = {
      {
        "<leader>aP",
        "<cmd>Copilot panel<cr>",
        desc = "Copilot Panel",
      },
    },
    opts = {
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "<M-Tab>",
          open = "<M-space>",
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 75,
        keymap = {
          accept = "<C-f>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = { ["*"] = true },
      copilot_node_command = "node", -- Node version must be < 18
      cmp = {
        enabled = true,
        method = "getCompletionsCycling",
      },
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
    },
  },
}
