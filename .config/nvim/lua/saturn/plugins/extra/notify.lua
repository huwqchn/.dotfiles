local M = {}

function M.config()
  saturn.plugins.notify = {
    active = true,
    on_config_done = function(notify)
      vim.notify = notify
      local notify_filter = vim.notify
      vim.notify = function(msg, ...)
        if msg:match "character_offset must be called" then
          return
        end
        if msg:match "method textDocument" then
          return
        end

        notify_filter(msg, ...)
      end
    end,
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
  }
end

function M.setup()
  local status_ok, notify = pcall(require, "notify")
  if not status_ok then
    return
  end
  notify.setup(saturn.plugins.notify)
  if saturn.plugins.notify.on_config_done then
    saturn.plugins.notify.on_config_done(notify)
  end
end

return M
