local M = {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim" },
    { "tamago324/nlsp-settings.nvim" },
    -- {
    --   "Maan2003/lsp_lines.nvim",
    --   config = true,
    --   enabled = saturn.enable_extra_plugins and not saturn.lsp.diagnostics.virtual_text,
    -- },
    {
      "ray-x/lsp_signature.nvim",
      config = true,
      enabled = saturn.enable_extra_plugins,
    },

    -- LSP load progress
    {
      "j-hui/fidget.nvim",
      config = true,
      enabled = saturn.enable_extra_plugins,
    },
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    { "folke/neodev.nvim", config = true },
    "hrsh7th/cmp-nvim-lsp",
  },
}

local lsp_config = require("saturn.plugins.lsp.config")
local utils = require("saturn.utils.helper")
local format = require("saturn.utiles.format")
local loader = require("saturn.utiles.loader")
saturn.lsp = vim.deepcopy(lsp_config)

function M.init()
  saturn.lsp.diagnostics.virtual_text = true
  saturn.format_on_save.enabled = true
end

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
    loader.clear_augroup("lsp_document_highlight")
  end
  if saturn.lsp.code_lens_refresh then
    loader.cleer_augroup("lsp_code_lens_refresh")
  end
end

function M.common_on_init(client, bufnr)
  if saturn.lsp.on_init_callback then
    saturn.lsp.on_init_callback(client, bufnr)
    print("Called lsp.on_init_callback")
    return
  end
end

function M.common_on_attach(client, bufnr)
  if saturn.lsp.on_attach_callback then
    saturn.lsp.on_attach_callback(client, bufnr)
    print("Called lsp.on_attach_callback")
  end
  local lu = require("saturn.plugins.lsp.utils")
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
  print("Setting up LSP support")

  local lsp_status_ok, _ = pcall(require, "lspconfig")
  if not lsp_status_ok then
    return
  end

  if saturn.use_icons then
    for _, sign in ipairs(saturn.lsp.diagnostics.signs.values) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end
  end

  require("saturn.plugins.lsp.handlers").setup()

  if not utils.is_directory(saturn.lsp.templates_dir) then
    require("saturn.plugins.lsp.templates").generate_templates()
  end

  pcall(function()
    require("nlspsettings").setup(saturn.lsp.nlsp_settings.setup)
  end)

  pcall(function()
    require("mason-lspconfig").setup(saturn.lsp.installer.setup)
    local util = require("lspconfig.util")
    -- automatic_installation is handled by lsp-manager
    util.on_setup = nil
  end)

  require("saturn.plugins.lsp.null-ls").setup()

  format.configure_format_on_save()
end

return M
