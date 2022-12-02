-- set a linter for cpp
-- local linters = require "saturn.plugins.core.lsp.null-ls.linters"
-- linters.setup {
--   { command = "cpplint", filetypes = { "cpp" } }
-- }

-- set a formatter for cpp
local formatters = require "saturn.plugins.core.lsp.null-ls.formatters"
formatters.setup {
  { command = "clang-format", filetypes = { "cpp" } }
}

-- set a lsp for cpp
local manager = require 'saturn.plugins.core.lsp.manager'
manager.setup("clangd", {
  on_init = require("saturn.plugins.core.lsp").common_on_init,
  capabilities = require("saturn.plugins.core.lsp").common_capabilities(),
} )
