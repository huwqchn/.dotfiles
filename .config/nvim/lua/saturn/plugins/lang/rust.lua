return {
  {
    "christianchiarulli/rust-tools.nvim",
    branch = "modularize_and_inlay_rewrite",
    ft = "rust",
    keys = {
      { "<leader>nr", "<cmd>RustRunnables<cr>", desc = "Runnables" },
      { "<leader>nm", "<cmd>RustExpandMacro<cr>", desc = "Expand Macro" },
      { "<leader>nc", "<cmd>RustOpenCargo<cr>", desc = "Open Cargo" },
      { "<leader>nD", "<cmd>RustOpenExternalDocs<cr>", desc = "Open Docs" },
      { "<leader>np", "<cmd>RustParentModule<cr>", desc = "Parent Module" },
      { "<leader>nd", "<cmd>RustDebuggables<cr>", desc = "Debuggables" },
      { "<leader>nv", "<cmd>RustViewCrateGraph<cr>", desc = "View Crate Graph" },
      {
        "<leader>nR",
        "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
        "Reload Workspace",
      },
      { "<leader>nu", "<cmd>RustMoveItemUp<cr>", desc = "Move Item Up" },
      { "<leader>ne", "<cmd>RustMoveItemDown<cr>", desc = "Move Item Down" },
    },
    config = function()
      local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
      local codelldb_adapter = {
        type = "server",
        port = "${port}",
        executable = {
          command = mason_path .. "bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      require("rust-tools").setup({
        tools = {
          executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
          reload_workspace_from_cargo_toml = true,
          runnables = {
            use_telescope = true,
          },
          inlay_hints = {
            auto = false,
            only_current_line = false,
            show_parameter_hints = false,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = {
            border = "rounded",
          },
          on_initialized = function()
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
              pattern = { "*.rs" },
              callback = function()
                local _, _ = pcall(vim.lsp.codelens.refresh)
              end,
            })
          end,
        },
        dap = {
          adapter = codelldb_adapter,
        },
        server = {
          on_attach = function(client, bufnr)
            require("saturn.plugins.lsp.hooks").common_on_attach(client, bufnr)
            local rt = require("rust-tools")
            -- Hover actions
            vim.keymap.set("n", "H", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
            -- Join
            vim.keymap.set("n", "J", rt.join_lines.join_lines, { buffer = bufnr })
          end,

          capabilities = require("saturn.plugins.lsp.hooks").common_capabilities(),
          settings = {
            ["rust-analyzer"] = {
              lens = {
                enable = true,
              },
              checkOnSave = {
                enable = true,
                command = "clippy",
              },
            },
          },
        },
      })
    end,
  },
  {
    "Saecki/crates.nvim",
    version = "v0.3.0",
    dependencies = { "plenary.nvim" },
    ft = { "rust", "toml" },
    opts = {
      popup = {
        border = "rounded",
      },
      null_ls = {
        enable = true,
        name = "crates.nvim",
      },
    },
  },
}
