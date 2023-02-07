vim.opt_local.textwidth = 100
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.commentstring = "//  %s"
vim.opt_local.cindent = true
vim.opt_local.cinoptions:append("g0,N-s,E-s,l1,:0")
vim.wo.wrap = false

require("saturn.plugins.lsp.null-ls.formatters").setup({
  { command = "clang-format", filetype = { "c" } },
})

require("saturn.plugins.lsp.manager").setup("clangd", {
  on_attach = function(client, bufnr)
    vim.keymap.set(
      "n",
      "<leader><space>",
      "<cmd>ClangdSwitchSourceHeader<cr>",
      { desc = "switch between header and source" }
    )
    require("saturn.plugins.lsp.hooks").common_on_attach(client, bufnr)
  end,
})
saturn.plugins.dap.on_config_done = require("saturn.utils.dap").dap_cpp
