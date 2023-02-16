local M = {}

-- local utils = require("saturn.utils.helper")
-- local format = require("saturn.utils.format")
local autocmd = require("saturn.utils.autocmd")

local function add_lsp_buffer_options(bufnr)
  for k, v in pairs(saturn.lsp.buffer_options) do
    vim.api.nvim_buf_set_option(bufnr, k, v)
  end
end

function M.common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end

function M.common_on_exit(_, _)
  if saturn.lsp.document_highlight then
    autocmd.clear_augroup("lsp_document_highlight")
  end
  if saturn.lsp.code_lens_refresh then
    autocmd.cleer_augroup("lsp_code_lens_refresh")
  end
end

function M.common_on_init(client, bufnr)
  -- ...
end

function M.common_on_attach(client, bufnr)
  local lu = require("saturn.plugins.lsp.utils")
  if saturn.lsp.document_highlight then
    lu.setup_document_highlight(client, bufnr)
  end
  if saturn.lsp.code_lens_refresh then
    lu.setup_codelens_refresh(client, bufnr)
  end
  -- add keymaps
  require("saturn.plugins.lsp.keymaps").on_attach(client, bufnr)
  require("saturn.plugins.lsp.format").on_attach(client, bufnr)
  add_lsp_buffer_options(bufnr)
  lu.setup_document_symbols(client, bufnr)
end

function M.get_common_opts()
  return {
    on_attach = M.common_on_attach,
    on_init = M.common_on_init,
    on_exit = M.common_on_exit,
    capabilities = M.common_capabilities(),
  }
end

return M
