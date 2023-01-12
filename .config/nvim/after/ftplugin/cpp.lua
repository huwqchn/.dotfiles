vim.opt_local.textwidth = 100
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.commentstring = "//  %s"
vim.opt_local.cindent = true
vim.opt_local.cinoptions:append("g0,N-s,E-s,l1,:0")
vim.wo.wrap = false

require("saturn.plugins.lsp.null-ls.formatters").setup({
  { command = "clang-format", filetype = { "cpp" } }
})

require("saturn.plugins.lsp.manager").setup("clangd")
