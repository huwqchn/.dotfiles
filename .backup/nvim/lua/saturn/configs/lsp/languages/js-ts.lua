-- Setup lsp.
vim.list_extend(saturn.lsp.automatic_configuration.skipped_servers, { "tsserver" })

local capabilities = require("saturn.plugins.lsp").common_capabilities()

local present, typescript = pcall(require, "typescript");
if present then
  typescript.setup {
    -- disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
      fallback = true, -- fall back to standard LSP definition on failure
    },
    server = { -- pass options to lspconfig's setup method
      on_attach = require("saturn.plugins.lsp").common_on_attach,
      on_init = require("saturn.plugins.lsp").common_on_init,
      capabilities = capabilities,
    },
  }
end

-- Set a formatter.
local formatters = require "saturn.plugins.lsp.null-ls.formatters"
formatters.setup {
  { command = "prettier", filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" } },
}

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
local dap_present, dap_vscode_js = pcall(require, "dap-vscode-js")
if dap_present then
  dap_vscode_js.setup {
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    debugger_path = mason_path .. "packages/js-debug-adapter", -- Path to vscode-js-debug installation.
    -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
  }
end

for _, language in ipairs { "typescript", "javascript" } do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
  }
end

-- Set a linter.
-- local linters = require("saturn.plugins.lsp.null-ls.linters")
-- linters.setup({
--   { command = "eslint", filetypes = { "javascript", "typescript" } },
-- })
