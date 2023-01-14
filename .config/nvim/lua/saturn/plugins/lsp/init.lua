return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        signs = {
          active = true,
          values = {
            { name = "DiagnosticSignError", text = saturn.icons.diagnostics.Error },
            { name = "DiagnosticSignWarn", text = saturn.icons.diagnostics.Warning },
            { name = "DiagnosticSignHint", text = saturn.icons.diagnostics.Hint },
            { name = "DiagnosticSignInfo", text = saturn.icons.diagnostics.Info },
          },
        },
        virtual_text = { space = 4, prefix = saturn.icons.misc.Alien },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
          format = function(d)
            local code = d.code or (d.user_data and d.user_data.lsp.code)
            if code then
              return string.format("%s [%s]", d.message, code):gsub("1. ", "")
            end
            return d.message
          end,
        },
      },
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
      },
    },
    config = function(_, opts)
      if saturn.use_icons then
        for _, sign in ipairs(opts.diagnostics.signs.values) do
          vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
        end
      end

      local config = {
        virtual_text = opts.diagnostics.virtual_text,
        signs = opts.diagnostics.signs,
        underline = opts.diagnostics.underline,
        update_in_insert = opts.diagnostics.update_in_insert,
        serverity_sort = opts.diagnostics.severity_sort,
        float = opts.diagnostics.float,
      }
      vim.diagnostic.config(config)
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, opts.float)
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, opts.float)
      require("mason-lspconfig").setup(saturn.lsp.installer.setup)
      local util = require "lspconfig.util"
      -- automatic_installation is handled by lsp-manager
      util.on_setup = nil
    end,
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
      { "folke/neodev.nvim", config = true },
      { "smjonas/inc-rename.nvim", config = true },
      "mason.nvim",
      "cmp-nvim-lsp",
      "lvimuser/lsp-inlayhints.nvim",
      "ray-x/lsp_signature.nvim",
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        hint_prefix = saturn.icons.misc.Feather,
        timer_interval = 100,
        handler_opts = {
          border = "rounded",
        },
        toggle_key = [[<M-x>]],
        select_signature_key = [[<M-c>]],
      })
    end,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = function()
      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, args.buf)
        end,
      })
      require("lsp-inlayhints").setup()
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cI", "<cmd>Mason<cr>", desc = "Mason" } },
    lazy = false,
    config = function()
     require("mason").setup({
        ui = {
          border = "rounded",
          keymaps = {
            toggle_package_expand = "<CR>",
            install_package = "<Space>",
            update_package = "l",
            check_package_version = "c",
            update_all_packages = "L",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>",
          },
        },
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = {
      setup = {
        debug = false,
      },
      config = {},
    },
    config = function(_, opts)
      local default_opts = require("saturn.plugins.lsp.hooks").get_common_opts()
      require("null-ls").setup(vim.tbl_deep_extend("force", default_opts, opts))
    end,
  },
  {
    "b0o/SchemaStore.nvim",
  },
  {
    import = "saturn.plugins.lang.rust",
    ft = "rust",
  },
}
