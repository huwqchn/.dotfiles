return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        keymaps = {
          toggle_package_expand = "<Space>",
          install_package = "<CR>",
          check_package_version = "c",
          check_outdated_packages = "C",
          uninstall_package = "X",
          cancel_installation = "<C-c>",
          apply_language_filter = "<C-f>",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
    },
    init = function()
      local lsp_keys = require("lazyvim.plugins.lsp.keymaps")
      local keys = lsp_keys.get()
      for _, key in ipairs(keys) do
        if key[1] == "K" then
          key[1] = "I"
        elseif key[1] == "gK" then
          key[1] = "gi"
        elseif key[1] == "<c-k>" then
          key[1] = "<c-h>"
        end
      end
    end,
  },
}
