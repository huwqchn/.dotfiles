local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "saturn.plugins.core.lsp.mason"
require("saturn.plugins.core.lsp.handlers").setup()
require "saturn.plugins.core.lsp.null-ls"
