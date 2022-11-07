local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "saturn.plugins.lsp.mason"
require("saturn.plugins.lsp.handlers").setup()
require "saturn.plugins.lsp.null-ls"
