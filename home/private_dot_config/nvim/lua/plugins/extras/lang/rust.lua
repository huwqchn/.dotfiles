return {
  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function(_, opts)
      local keys = opts.servers.rust_analyzer.keys
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "I", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)", mode = { "n", "x" } }
      keys[#keys + 1] = {
        "<leader>ce",
        "<cmd>RustExpandMacro<cr>",
        desc = "Expand Macro (Rust)",
      }
      keys[#keys + 1] = {
        "<leader>c,",
        "<cmd>RustRunnables<cr>",
        desc = "Run (Rust)",
        mode = { "n", "x" },
      }
      keys[#keys + 1] = {
        "<leader>co",
        "<cmd>RustOpenCargo<cr>",
        desc = "Open Cargo (Rust)",
      }
      keys[#keys + 1] = {
        "s<space>",
        "<cmd>RustParentModule<cr>",
        desc = "Parent Module (Rust)",
      }
      keys[#keys + 1] = {
        "<leadea>c<Up>",
        "<cmd>RustMoveItemUp<cr>",
        desc = "Move Item up (Rust)",
      }
      keys[#keys + 1] = {
        "<leader>c<Down>",
        "<cmd>RustMoveItemDown<cr>",
        desc = "Move Item down (Rust)",
      }

      for _, key in ipairs(opts.servers.taplo.keys) do
        if key[1] == "K" then
          key[1] = "I"
          break
        end
      end
    end,
  },
}
