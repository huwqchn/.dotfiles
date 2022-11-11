local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "saturn.lsp.mason"
require("saturn.lsp.handlers").setup()
require "saturn.lsp.null-ls"
