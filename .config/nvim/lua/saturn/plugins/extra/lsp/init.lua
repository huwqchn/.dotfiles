local M = {}

function M.config()
  -- make sure server will always be installed even if the server is in skipped_servers list
  saturn.lsp.installer.setup.ensure_installed = {
      "sumneko_lua",
      "jsonls",
  }
  saturn.lsp.installer.setup.automatic_installation = false

  vim.list_extend(saturn.lsp.automatic_configuration.skipped_servers, { "pyright", "sumneko_lua" })
  -- saturn.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  --   return server ~= "emmet_ls"
  -- end, saturn.lsp.automatic_configuration.skipped_servers)

end

function M.setup()

  local manager = require("saturn.plugins.core.lsp.manager")
  manager.setup("pyright", {})
  manager.setup("sumneko_lua", {} )


  -- you can set a custom on_attach function that will be used for all the language servers
  -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
  -- saturn.lsp.on_attach_callback = function(client, bufnr)
  --   local function buf_set_option(...)
  --     vim.api.nvim_buf_set_option(bufnr, ...)
  --   end
  --   --Enable completion triggered by <c-x><c-o>
  --   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
  -- end

  -- set a formatter, this will override the language server formatting capabilities (if it exists)
  local formatters = require "saturn.plugins.core.lsp.null-ls.formatters"
  formatters.setup {
    { command = "black", filetypes = { "python" } },
    { command = "isort", filetypes = { "python" } },
    {
      -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
      command = "prettier",
      ---@usage arguments to pass to the formatter
      -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
      extra_args = { "--print-with", "100" },
      ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
      filetypes = { "typescript", "typescriptreact" },
    },
    { command = "google_java_format", filetypes = { "java" } },
    { command = "stylua", filetypes = { "lua" } },
    { command = "shfmt", filetypes = { "sh", "zsh" } },
  }

  -- set additional linters
  local linters = require "saturn.plugins.core.lsp.null-ls.linters"
  linters.setup {
    { command = "flake8", filetypes = { "python" } },
    {
      -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
      command = "shellcheck",
      ---@usage arguments to pass to the formatter
      -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
      extra_args = { "--severity", "warning" },
    },
    {
      command = "codespell",
      ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
      filetypes = { "javascript", "python" },
    },
    -- {
    --   command = "luacheck",
    --   filetypes = { "lua" },
    -- }
  }
end

return M
