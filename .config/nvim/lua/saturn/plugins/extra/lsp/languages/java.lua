local formatters = require "saturn.plugins.core.lsp.null-ls.formatters"
formatters.setup {
  { command = "google-java-format", filetypes = { "java" } }
}

