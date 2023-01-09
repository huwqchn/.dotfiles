local skipped_servers = {
  -- "angularls",
  -- "ansiblels",
  -- "ccls",
  -- "csharp_ls",
  -- "cssmodules_ls",
  -- "denols",
  -- "ember",
  -- "emmet_ls",
  -- "eslint",
  -- "eslintls",
  -- "glint",
  -- "golangci_lint_ls",
  -- "gradle_ls",
  -- "graphql",
  -- "jedi_language_server",
  -- "ltex",
  -- "ocamlls",
  -- "phpactor",
  -- "psalm",
  -- "pylsp",
  -- "quick_lint_js",
  -- "reason_ls",
  -- "rome",
  -- "ruby_ls",
  -- "scry",
  -- "solang",
  -- "solc",
  -- "solidity_ls",
  -- "sorbet",
  -- "sourcekit",
  -- "sourcery",
  -- "spectral",
  -- "sqlls",
  -- "sqls",
  -- "stylelint_lsp",
  -- "svlangserver",
  -- "tflint",
  -- "verible",
  -- "vuels",
}

local skipped_filetypes = { "markdown", "rst", "plaintext", "toml", "proto" }

return {
  templates_dir = vim.fn.stdpath("config") .. "/after/ftplugin",
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
    virtual_text = false,
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
  document_highlight = false,
  code_lens_refresh = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
  },
  on_attach_callback = nil,
  on_init_callback = nil,
  automatic_configuration = {
    ---@usage list of servers that the automatic installer will skip
    skipped_servers = skipped_servers,
    ---@usage list of filetypes that the automatic installer will skip
    skipped_filetypes = skipped_filetypes,
  },
  buffer_mappings = {
    normal_mode = {
      ["H"] = { vim.lsp.buf.hover, "Show hover" },
      ["gd"] = { vim.lsp.buf.definition, "Goto Definition" },
      ["gD"] = { vim.lsp.buf.declaration, "Goto declaration" },
      ["gr"] = { vim.lsp.buf.references, "Goto references" },
      ["gi"] = { vim.lsp.buf.implementation, "Goto Implementation" },
      ["gs"] = { vim.lsp.buf.signature_help, "show signature help" },
      ["gl"] = {
        function()
          local config = saturn.lsp.diagnostics.float
          config.scope = "line"
          vim.diagnostic.open_float(0, config)
        end,
        "Show line diagnostics",
      },
    },
    insert_mode = {},
    visual_mode = {},
  },
  buffer_options = {
    --- enable completion triggered by <c-x><c-o>
    omnifunc = "v:lua.vim.lsp.omnifunc",
    --- use gq for formatting
    formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:500})",
  },
  ---@usage list of settings of nvim-lsp-installer
  installer = {
    setup = {
      ensure_installed = {},
      automatic_installation = {
        exclude = {},
      },
    },
  },
  nlsp_settings = {
    setup = {
      config_home = vim.fn.stdpath("config") .. "/lsp-settings",
      -- set to false to overwrite schemastore.nvim
      append_default_schemas = true,
      ignored_servers = {},
      loader = "json",
    },
  },
  null_ls = {
    setup = {
      debug = false,
    },
    config = {},
  },
}
