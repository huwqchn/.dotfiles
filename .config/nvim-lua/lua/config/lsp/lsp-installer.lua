local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end
local lspconfig = require("lspconfig")

lsp_installer.setup({
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer", "sumneko_lua" }
  -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = { "sumneko_lua" },

  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  automatic_installation = false,
  ui = {
    check_outdated_servers_on_open = true,
    border = "none",
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    },
  },
  keymaps = {
    -- Keymap to expand a server in the UI
    toggle_server_expand = "<CR>",
    -- Keymap to install the server under the current cursor position
    install_server = "<SPACE>",
    -- Keymap to reinstall/update the server under the current cursor position
    update_server = "l",
    -- Keymap to check for new version for the server under the current cursor position
    check_server_version = "c",
    -- Keymap to update all installed servers
    update_all_servers = "L",
    -- Keymap to check which installed servers are outdated
    check_outdated_servers = "C",
    -- Keymap to uninstall a server
    uninstall_server = "X",
  },
})

local servers = {
  sumneko_lua = require("config.lsp.settings.lua"), -- lua/lsp/settings/lua.lua
}

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    config.on_setup(lspconfig[name])
  else
    -- default config
    lspconfig[name].setup({})
  end
end
