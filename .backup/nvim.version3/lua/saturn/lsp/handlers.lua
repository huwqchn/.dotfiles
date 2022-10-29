-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
local M = {}

function M.setup()
  local config = { -- your config
    virtual_text = saturn.lsp.diagnostics.virtual_text,
    signs = saturn.lsp.diagnostics.signs,
    underline = saturn.lsp.diagnostics.underline,
    update_in_insert = saturn.lsp.diagnostics.update_in_insert,
    severity_sort = saturn.lsp.diagnostics.severity_sort,
    float = saturn.lsp.diagnostics.float,
  }
  vim.diagnostic.config(config)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, saturn.lsp.float)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, saturn.lsp.float)
end

return M
