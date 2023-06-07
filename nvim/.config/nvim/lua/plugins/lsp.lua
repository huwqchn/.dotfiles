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
    "lvimuser/lsp-inlayhints.nvim",
    branch = "anticonceal",
    event = "LspAttach",
    opts = {},
    keys = {
      {
        "<leader>uh",
        function()
          require("lsp-inlayhints").toggle()
        end,
        desc = "Lsp Inlayhints Toggle",
      },
    },
    config = function(_, opts)
      require("lsp-inlayhints").setup(opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, args.buf)
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      local lsp_keys = require("lazyvim.plugins.lsp.keymaps")
      lsp_keys._keys = vim.tbl_extend("force", lsp_keys.get(), {
        { "I", vim.lsp.buf.hover, desc = "Hover" },
        { "gi", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
        { "<c-i>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
      })
    end,
  },
}
