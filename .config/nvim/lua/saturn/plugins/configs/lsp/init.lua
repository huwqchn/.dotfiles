local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "saturn.plugins.configs.lsp.mason"
require("saturn.plugins.configs.lsp.handlers").setup()
require "saturn.plugins.configs.lsp.null-ls"
