return {
  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function(_, opts)
      for _, key in ipairs(opts.servers.rust_analyzer.keys) do
        if key[1] == "K" then
          key[1] = "I"
          break
        end
      end
      local keys = {
        {
          "I",
          "<cmd>RustHoverRange<cr>",
          desc = "Hover Range (Rust)",
          mode = "x",
        },
        {
          "<leader>ce",
          "<cmd>RustExpandMacro<cr>",
          desc = "Expand Macro (Rust)",
        },
        {
          "<leader>c,",
          "<cmd>RustRunnables<cr>",
          desc = "Run (Rust)",
          mode = { "n", "x" },
        },
        {
          "<leader>co",
          "<cmd>RustOpenCargo<cr>",
          desc = "Open Cargo (Rust)",
        },
        {
          "s<space>",
          "<cmd>RustParentModule<cr>",
          desc = "Parent Module (Rust)",
        },
        {
          "<leadea>c<Up>",
          "<cmd>RustMoveItemUp<cr>",
          desc = "Move Item up (Rust)",
        },
        {
          "s<Down>",
          "<cmd>RustMoveItemDown<cr>",
          desc = "Move Item down (Rust)",
        },
      }
      vim.list_extend(opts.servers.rust_analyzer.keys, keys)
      for _, key in ipairs(opts.servers.taplo.keys) do
        if key[1] == "K" then
          key[1] = "I"
          break
        end
      end
    end,
  },
}
