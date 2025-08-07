return {
  {
    import = "lazyvim.plugins.extras.ai.copilot",
  },
  {
    import = "lazyvim.plugins.extras.ai.copilot-chat",
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
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    optional = true,
    opts = {
      mappings = {
        -- Submit the prompt to Copilot
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-CR>",
        },
      },
      prompts = {
        -- Code related prompts
        Refactor = {
          prompt = "Please refactor the following code to improve its clarity and readability.",
        },
        FixError = {
          prompt = "Please explain the error in the following text and provide a solution.",
        },
        BetterNamings = {
          prompt = "Please provide better names for the following variables and functions.",
        },
        Documentation = {
          prompt = "Please provide documentation for the following code.",
        },
        SwaggerApiDocs = {
          prompt = "Please provide documentation for the following API using Swagger.",
        },
        SwaggerJsDocs = {
          prompt = "Please write JSDoc for the following API using Swagger.",
        },
        -- Text related prompts
        Summarize = {
          prompt = "Please summarize the following text.",
        },
        Spelling = {
          prompt = "Please correct any grammar and spelling errors in the following text.",
        },
        Wording = {
          prompt = "Please improve the grammar and wording of the following text.",
        },
        Concise = {
          prompt = "Please rewrite the following text to make it more concise.",
        },
      },
    },
    keys = {
      -- Code related commands
      { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain code (CopilotChat)" },
      { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate tests (CopilotChat)" },
      { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review code (CopilotChat) " },
      { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "Refactor code (CopilotChat)" },
      { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "Better Naming (CopilotChat)" },
      -- save and load
      {
        "<leader>as",
        function()
          local input = vim.fn.input("Save chat name as: ")
          if input ~= "" then
            vim.cmd("CopilotChatSave " .. input)
          end
        end,
        desc = "Save chat (CopilotChat)",
      },
      {
        "<leader>ao",
        function()
          local input = vim.fn.input("Load chat name: ")
          if input ~= "" then
            vim.cmd("CopilotChatLoad " .. input)
          end
        end,
        desc = "load chat (CopilotChat)",
      },

      -- Generate commit message based on the git diff
      {
        "<leader>am",
        "<cmd>CopilotChatCommit<cr>",
        desc = "Generate commit message for all changes (CopilotChat)",
      },
      {
        "<leader>aM",
        "<cmd>CopilotChatCommitStaged<cr>",
        desc = "Generate commit message for staged changes (CopilotChat)",
      },
      -- Debug
      { "<leader>aD", "<cmd>CopilotChatDebugInfo<cr>", desc = "Debug Info (CopilotChat)" },
      -- Fix the issue with diagnostic
      { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix Diagnostic (CopilotChat)" },
    },
  },
}
