require("saturn.configs.lsp.languages.lua")

local formatters = require("saturn.plugins.lsp.null-ls.formatters")
formatters.setup({
  { command = "stylua", filetypes = { "lua" } },
})
