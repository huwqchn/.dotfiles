require("saturn.plugins.lsp.manager").setup("sumneko_lua")
require("saturn.plugins.lsp.null-ls.formatters").setup({
  { command = "stylua", args = { "lua" } },
})
