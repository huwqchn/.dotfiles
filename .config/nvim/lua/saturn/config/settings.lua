return {
  leaderkey = " ",
  colorscheme = "tokyonight",
  transparent_window = false,
  format_on_save = {
    ---@usage boolean: format on save (Default: false)
    enabled = false,
    ---@usage pattern string pattern used for the autocommand (Default: '*')
    pattern = "*",
    ---@usage timeout number timeout in ms for the format request (Default: 1000)
    timeout = 1000,
    ---@usage filter func to select client
    -- filter = require("saturn.plugins.core.lsp.utils").format_filter,
  },
  use_icons = true,
  icons = require("saturn.config.ui.icons"),
  plugins = {},
}
