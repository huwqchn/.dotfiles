return {
  {
    "christianchiarulli/rust-tools.nvim",
    branch = "modularize_and_inlay_rewrite",
    ft = "rust",
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
            -- Leader key
            vim.keymap.set("n", "<leader>nr", "<cmd>RustRunnables<cr>", { desc = "Runnables" })
            vim.keymap.set("n", "<leader>nm", "<cmd>RustExpandMacro<cr>", { desc = "Expand Macro" })
            vim.keymap.set("n", "<leader>nC", "<cmd>RustOpenCargo<cr>", { desc = "Open Cargo" })
            vim.keymap.set("n", "<leader>nD", "<cmd>RustOpenExternalDocs<cr>", { desc = "Open Docs" })
            vim.keymap.set("n", "<leader>np", "<cmd>RustParentModule<cr>", { desc = "Parent Module" })
            vim.keymap.set("n", "<leader>nd", "<cmd>RustDebuggables<cr>", { desc = "Debuggables" })
            vim.keymap.set("n", "<leader>nv", "<cmd>RustViewCrateGraph<cr>", { desc = "View Crate Graph" })
            vim.keymap.set(
              "n",
              "<leader>nR",
              "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
              { desc = "Reload Workspace" }
            )
            vim.keymap.set("n", "<leader>nu", "<cmd>RustMoveItemUp<cr>", { desc = "Move Item Up" })
            vim.keymap.set("n", "<leader>ne", "<cmd>RustMoveItemDown<cr>", { desc = "Move Item Down" })
            -- crates
            local crates = require("crates")
            vim.keymap.set("n", "<leader>nct", crates.toggle, { desc = "crates toggle" })
            vim.keymap.set("n", "<leader>ncr", crates.reload, { desc = "crates reload" })

            vim.keymap.set("n", "<leader>ncv", crates.show_versions_popup, { desc = "crates show versions popup" })
            vim.keymap.set("n", "<leader>ncf", crates.show_features_popup, { desc = "crates show features popup" })
            vim.keymap.set(
              "n",
              "<leader>ncd",
              crates.show_dependencies_popup,
              { desc = "crates show dependencies popup" }
            )

            vim.keymap.set("n", "<leader>ncu", crates.update_crate, { desc = "update crate" })
            vim.keymap.set("v", "<leader>ncu", crates.update_crates, { desc = "update crates" })
            vim.keymap.set("n", "<leader>nca", crates.update_all_crates, { desc = "update all crates" })
            vim.keymap.set("n", "<leader>ncU", crates.upgrade_crate, { desc = "upgrade crate" })
            vim.keymap.set("v", "<leader>ncU", crates.upgrade_crates, { desc = "upgrade crates" })
            vim.keymap.set("n", "<leader>ncA", crates.upgrade_all_crates, { desc = "upgrade all crates" })

            vim.keymap.set("n", "<leader>ncH", crates.open_homepage, { desc = "open homepage" })
            vim.keymap.set("n", "<leader>ncR", crates.open_repository, { desc = "open repository" })
            vim.keymap.set("n", "<leader>ncD", crates.open_documentation, { desc = "open documentation" })
            vim.keymap.set("n", "<leader>ncC", crates.open_crates_io, { desc = "open crates io" })
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
    dependencies = { "plenary.nvim", "nvim-cmp" },
    ft = { "rust", "toml" },
    opts = {
      null_ls = {
        enable = true,
        name = "crates.nvim",
      },
    },
  },
}
