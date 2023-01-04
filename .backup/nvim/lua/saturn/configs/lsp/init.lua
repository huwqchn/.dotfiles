local M = {}

function M.config()
  -- make sure server will always be installed even if the server is in skipped_servers list
  saturn.lsp.installer.setup.ensure_installed = {
    "sumneko_lua",
    "jsonls",
    "pyright",
  }
  saturn.plugins.treesitter.ensure_installed = {
    "java",
    "cpp",
    "lua",
  }
  -- saturn.lsp.installer.setup.automatic_installation = false

  vim.list_extend(saturn.lsp.automatic_configuration.skipped_servers, { "pyright", "sumneko_lua" })
  -- saturn.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  --   return server ~= "emmet_ls"
  -- end, saturn.lsp.automatic_configuration.skipped_servers)
end

function M.setup()
  require("saturn.configs.lsp.languages.go")
  require("saturn.configs.lsp.languages.rust")
  require("saturn.configs.lsp.languages.lua")
  require("saturn.configs.lsp.languages.python")
  require("saturn.configs.lsp.languages.js-ts")
  require("saturn.configs.lsp.languages.sh")
  require("saturn.configs.lsp.languages.cpp")

  local formatters = require("saturn.plugins.lsp.null-ls.formatters")
  formatters.setup({
    { command = "google_java_format", filetypes = { "java" } },
    { command = "stylua", filetypes = { "lua" } },
    { command = "shfmt", filetypes = { "sh", "zsh" } },
  })
end

return M
