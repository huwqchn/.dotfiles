local M = {}

function M.init()
  local colors = require("tokyonight.colors").setup()
  saturn.plugins.scrollbar = {
    active = true,
    on_config_done = nil,
    handle = {
      color = colors.bg_highlight,
    },
    excluded_filetypes = {
      "prompt",
      "TelescopePrompt",
      "noice",
      "notify",
    },
    marks = {
      Search = { color = colors.orange },
      Error = { color = colors.error },
      Warn = { color = colors.warning },
      Info = { color = colors.info },
      Hint = { color = colors.hint },
      Misc = { color = colors.purple },
    },
  }
end

function M.config()
  local scrollbar = require("scrollbar")
  scrollbar.setup(saturn.plugins.scrollbar)
  if saturn.plugins.scrollbar.on_config_done then
    saturn.plugins.scrollbar.on_config_done(scrollbar)
  end
end

return M
