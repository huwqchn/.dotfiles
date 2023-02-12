return {
  leaderkey = " ",
  localleaderkey = ",",
  colorscheme = "tokyonight",
  transparent_window = false,
  format_on_save = {
    ---@usage boolean: format on save (Default: true)
    enabled = true,
    ---@usage pattern string pattern used for the autocommand (Default: '*')
    pattern = "*",
    ---@usage timeout number timeout in ms for the format request (Default: 1000)
    timeout = 1000,
    ---@usage filter func to select client
    -- filter = require("saturn.plugins.core.lsp.utils").format_filter,
  },
  lsp = {
    buffer_options = {
      --- enable completion triggered by <c-x><c-o>
      omnifunc = "v:lua.vim.lsp.omnifunc",
      --- use gq for formatting
      formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:500})",
    },
    document_highlight = true,
    code_lens_refresh = true,
    installer = {
      setup = {
        ensure_installed = { "lua_ls", "jsonls", "clangd", "pyright" },
        automatic_installation = {
          exclude = {},
        },
      },
    },
  },
  use_icons = true,
  icons = require("saturn.config.ui.icons"),
  plugins = {},
}
