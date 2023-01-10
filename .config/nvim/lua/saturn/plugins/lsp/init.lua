return {
  -- lspconfig
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
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
      virtual_text = { space = 4, prefix = saturn.icons.misc.CleanCode },
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
  end,
  dependencies = {
    { "williamboman/mason-lspconfig.nvim" },
    { "folke/neodev.nvim", config = true },
    {
      "ray-x/lsp_signature.nvim",
      opts = {
        hint_prefix = saturn.icons.misc.Feather,
        floating_window_off_x = 5, -- adjust float windows x position.
        floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
          local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
          local pumheight = vim.o.pumheight
          local winline = vim.fn.winline() -- line number in the window
          local winheight = vim.fn.winheight(0)

          -- window top
          if winline - 1 < pumheight then
            return pumheight
          end

          -- window bottom
          if winheight - winline < pumheight then
            return -pumheight
          end
          return 0
        end,
      },
    },
  }
}
