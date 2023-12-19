return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        keymaps = {
          toggle_package_expand = "<Space>",
          install_package = "<CR>",
          check_package_version = "c",
          check_outdated_packages = "C",
          uninstall_package = "X",
          cancel_installation = "<C-c>",
          apply_language_filter = "<C-f>",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable default help keys
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "gK", false }
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }

      -- enable my custom keys
      keys[#keys + 1] = { "I", vim.lsp.buf.hover, desc = "Hover" }
      keys[#keys + 1] = { "gI", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" }
      keys[#keys + 1] =
        { "<c-h>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" }
    end,
  },
}
