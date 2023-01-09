local M = {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  keys = {
    {
      "<leader>;d",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Delete all Notifications",
    },
  },
  enabled = saturn.enable_extra_plugins,
}

saturn.plugins.notify = {
  -- Animation style (see below for details)
  stages = "fade_in_slide_out",

  -- Function called when a new window is opened, use for changing win settings/config
  on_open = nil,

  -- Function called when a window is closed
  on_close = nil,

  -- Render function for notifications. See notify-render()
  render = "default",

  -- Default timeout for notifications
  timeout = 175,

  -- For stages that change opacity this is treated as the highlight behind the window
  -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
  background_colour = "Normal",

  -- Minimum width for notification windows
  minimum_width = 10,

  -- Icons for the different levels
  icons = {
    ERROR = saturn.icons.diagnostics.Error,
    WARN = saturn.icons.diagnostics.Warning,
    INFO = saturn.icons.diagnostics.Information,
    DEBUG = saturn.icons.ui.Bug,
    TRACE = saturn.icons.ui.Pencil,
  },
  max_height = function()
    return math.floor(vim.o.lines * 0.75)
  end,
  max_width = function()
    return math.floor(vim.o.columns * 0.75)
  end,
}

function M.init()
  saturn.plugins.whichkey.mappings[";"] = {
    name = "noice",
  }
end

function M.config()
  local notify = require("notify")
  notify.setup(saturn.plugins.notify)
  local notify_filter = notify
  vim.notify = function(msg, ...)
    if msg:match("character_offset must be called") then
      return
    end
    if msg:match("method textDocument") then
      return
    end
    if
      msg:match("warning: multiple different client offset_encodings detected for buffer, this is not supported yet")
    then
      return
    end

    notify_filter(msg, ...)
  end
end

return M
