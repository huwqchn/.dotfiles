vim.keymap.set(
  "n",
  "<space><space>",
  ":e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.c,<CR>",
  { noremap = true, silent = true }
)

require("saturn.configs.lsp.languages.cpp")

vim.opt_local.textwidth = 100
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

vim.opt_local.commentstring = "// %s"

vim.opt_local.cindent = true -- stricter rules for C programs
vim.opt_local.cinoptions:append("g0,N-s,E-s,l1,:0")
vim.wo.wrap = false
