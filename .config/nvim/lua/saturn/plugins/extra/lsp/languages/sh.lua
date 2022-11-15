local formatters = require "saturn.plugins.core.lsp.null-ls.formatters"
formatters.setup {
  { command = "shfmt", filetypes = { "sh", "zsh", "bash" } },
}

vim.filetype.add {
  extension = {
    zsh = "zsh",
  },
}

vim.list_extend(saturn.lsp.automatic_configuration.skipped_servers, { "bashls" })

local lsp_manager = require "saturn.plugins.core.lsp.manager"
lsp_manager.setup("bashls", {
  filetypes = { "sh", "zsh" },
  on_init = require("saturn.plugins.core.lsp").common_on_init,
  capabilities = require("saturn.plugins.core.lsp").common_capabilities(),
})
