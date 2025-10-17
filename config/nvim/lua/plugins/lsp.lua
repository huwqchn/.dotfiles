return {
  {
    "mason-org/mason.nvim",
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
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable default help keys
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "gK", false }
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }
      keys[#keys + 1] = { "<a-n>", false }
      keys[#keys + 1] = { "<a-p>", false }

      -- enable my custom keys
      keys[#keys + 1] = { "I", vim.lsp.buf.hover, desc = "Hover" }
      keys[#keys + 1] = { "gI", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" }
      keys[#keys + 1] =
        { "<c-h>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" }
      keys[#keys + 1] = {
        "<a-.>",
        function()
          Snacks.words.jump(vim.v.count1, true)
        end,
        has = "documentHighlight",
        desc = "Next Reference",
        cond = function()
          return Snacks.words.is_enabled()
        end,
      }
      keys[#keys + 1] = {
        "<a-,>",
        function()
          Snacks.words.jump(-vim.v.count1, true)
        end,
        has = "documentHighlight",
        desc = "Prev Reference",
        cond = function()
          return Snacks.words.is_enabled()
        end,
      }
    end,
  },
}
