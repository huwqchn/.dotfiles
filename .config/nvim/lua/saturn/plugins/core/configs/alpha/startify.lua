local M = {}

function M.get_sections()
  local header = {
    type = "text",
    val = require 'saturn.core.ui.name',
    opts = {
      hl = "Label",
      shrink_margin = false,
      -- wrap = "overflow";
    },
  }

  local top_buttons = {
    entries = {
      { "e", saturn.icons.ui.NewFile .. " New File", "<CMD>ene!<CR>" },
    },
    val = {},
  }

  local bottom_buttons = {
    entries = {
      { "q", "Quit", "<CMD>quit<CR>" },
    },
    val = {},
  }

  local footer = {
    type = "group",
    val = {},
  }

  return {
    header = header,
    top_buttons = top_buttons,
    bottom_buttons = bottom_buttons,
    -- this is probably broken
    footer = footer,
  }
end

return M
