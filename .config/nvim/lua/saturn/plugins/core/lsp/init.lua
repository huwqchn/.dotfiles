local M = {}
local Log = require "saturn.plugins.log"
local utils = require "saturn.utils.helper"
local autocmds = require "saturn.basic.autocmds"

local function add_lsp_buffer_options(bufnr)
  for k, v in pairs(saturn.lsp.buffer_options) do
    vim.api.nvim_buf_set_option(bufnr, k, v)
  end
end

local function add_lsp_buffer_keybindings(bufnr)
  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }

  for mode_name, mode_char in pairs(mappings) do
    for key, remap in pairs(saturn.lsp.buffer_mappings[mode_name]) do
      local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
      vim.keymap.set(mode_char, key, remap[1], opts)
    end
  end
end

function M.common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end

function M.common_on_exit(_, _)
  if saturn.lsp.document_highlight then
    autocmds.clear_augroup "lsp_document_highlight"
  end
  if saturn.lsp.code_lens_refresh then
    autocmds.cleer_augroup "lsp_code_lens_refresh"
  end
end

function M.common_on_init(client, bufnr)
  if saturn.lsp.on_init_callback then
    saturn.lsp.on_init_callback(client, bufnr)
    Log:debug "Called lsp.on_init_callback"
    return
  end
end

function M.common_on_attach(client, bufnr)
  if saturn.lsp.on_attach_callback then
    saturn.lsp.on_attach_callback(client, bufnr)
    Log:debug "Called lsp.on_attach_callback"
  end
  local lu = require "saturn.plugins.core.lsp.utils"
  if saturn.lsp.document_highlight then
    lu.setup_document_highlight(client, bufnr)
  end
  if saturn.lsp.code_lens_refresh then
    lu.setup_codelens_refresh(client, bufnr)
  end
  add_lsp_buffer_keybindings(bufnr)
  add_lsp_buffer_options(bufnr)
  lu.setup_document_symbols(client, bufnr)
end

function M.get_common_opts()
  return {
    on_attach = M.common_on_attach,
    on_init = M.common_on_init,
    on_exit = M.common_on_exit,
    capabilities = M.common_capabilities(),
  }
end

function M.config()
  local lsp_config = require "saturn.plugins.core.lsp.config"
  saturn.lsp = vim.deepcopy(lsp_config)
  saturn.plugins.luasnip = {
    sources = {
      friendly_snippets = true,
    },
  }

  -- make sure server will always be installed even if the server is in skipped_servers list
  saturn.lsp.installer.setup.ensure_installed = {
      "sumneko_lua",
      "jsonls",
  }
  saturn.lsp.installer.setup.automatic_installation = false

  vim.list_extend(saturn.lsp.automatic_configuration.skipped_servers, { "pyright" })
  local opts = {} -- check the lspconfig documentation for a list of all possible options
  require("saturn.plugins.core.lsp.manager").setup("pyright", opts)

  saturn.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
    return server ~= "emmet_ls"
  end, saturn.lsp.automatic_configuration.skipped_servers)

  -- you can set a custom on_attach function that will be used for all the language servers
  -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
  saturn.lsp.on_attach_callback = function(client, bufnr)
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end
    --Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
  end

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
  }
end

function M.setup()
  Log:debug "Setting up LSP support"

  local lsp_status_ok, _ = pcall(require, "lspconfig")
  if not lsp_status_ok then
    return
  end

  if saturn.use_icons then
    for _, sign in ipairs(saturn.lsp.diagnostics.signs.values) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end
  end

  require("saturn.plugins.core.lsp.handlers").setup()

  if not utils.is_directory(saturn.lsp.templates_dir) then
    require("saturn.plugins.core.lsp.templates").generate_templates()
  end

  pcall(function()
    require("nlspsettings").setup(saturn.lsp.nlsp_settings.setup)
  end)

  pcall(function()
    require("mason-lspconfig").setup(saturn.lsp.installer.setup)
    local util = require "lspconfig.util"
    -- automatic_installation is handled by lsp-manager
    util.on_setup = nil
  end)

  require("saturn.plugins.core.lsp.null-ls").setup()

  autocmds.configure_format_on_save()
end

return M
