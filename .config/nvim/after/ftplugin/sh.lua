vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt.cmdheight = 1

require("saturn.configs.lsp.languages.sh")

local formatters = require("saturn.plugins.lsp.null-ls.formatters")
formatters.setup({
  { command = "shfmt", filetypes = { "sh", "zsh" } },
})
