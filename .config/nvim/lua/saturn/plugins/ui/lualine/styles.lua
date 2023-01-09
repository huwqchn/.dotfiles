local M = {}
local components = require "saturn.plugins.ui.lualine.components"
local conditions = require "saturn.plugins.ui.lualine.conditions"
local colors = require "saturn.plugins.ui.lualine.colors"

local styles = {
  saturn = nil,
  default = nil,
  none = nil,
  evil = nil,
}

styles.none = {
  style = "none",
  options = {
    theme = "auto",
    globalstatus = true,
    icons_enabled = saturn.use_icons,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}

styles.default = {
  style = "default",
  options = {
    theme = "auto",
    globalstatus = true,
    icons_enabled = saturn.use_icons,
    component_separators = {
      left = saturn.icons.ui.DividerRight,
      right = saturn.icons.ui.DividerLeft,
    },
    section_separators = {
      left = saturn.icons.ui.BoldDividerRight,
      right = saturn.icons.ui.BoldDividerLeft,
    },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}

styles.saturn = {
  style = "saturn",
  options = {
    theme = "auto",
    globalstatus = true,
    icons_enabled = saturn.use_icons,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "lazy" },
  },
  sections = {
    lualine_a = {
      components.mode,
    },
    lualine_b = {
      components.branch,
    },
    lualine_c = {
      components.diff,
      components.python_env,
    },
    lualine_x = {
      components.diagnostics,
      components.lsp,
      components.spaces,
      components.filetype,
    },
    lualine_y = { components.location },
    lualine_z = {
      components.progress,
    },
  },
  inactive_sections = {
    lualine_a = {
      components.mode,
    },
    lualine_b = {
      components.branch,
    },
    lualine_c = {
      components.diff,
      components.python_env,
    },
    lualine_x = {
      components.diagnostics,
      components.lsp,
      components.spaces,
      components.filetype,
    },
    lualine_y = { components.location },
    lualine_z = {
      components.progress,
    },
  },
  tabline = {},
  extensions = {},
}

styles.evil = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = {
        a = { fg = colors.fg, bg = colors.bg },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
        x = { fg = colors.fg, bg = colors.bg },
        y = { fg = colors.fg, bg = colors.bg },
        z = { fg = colors.fg, bg = colors.bg },
      },
      inactive = {
        a = { fg = colors.fg, bg = colors.bg },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
        x = { fg = colors.fg, bg = colors.bg },
        y = { fg = colors.fg, bg = colors.bg },
        z = { fg = colors.fg, bg = colors.bg },
      },
    },
  },
  sections = {
    lualine_a = {
      components.left_notch,
      components.evil_mode,
    },
    lualine_b = {
      components.evil_branch,
    },
    lualine_c = {
      components.evil_diff,
    },
    lualine_x = {
      components.lsp,
      components.diagnostics,
    },
    lualine_y = {
      components.encoding,
      components.fileformat,
    },
    lualine_z = {
      components.location,
      components.progress,
      components.right_notch,
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

function M.get_style(style)
  local style_keys = vim.tbl_keys(styles)
  if not vim.tbl_contains(style_keys, style) then
    print(
      "Invalid lualine style"
        .. string.format('"%s"', style)
        .. "options are: "
        .. string.format('"%s"', table.concat(style_keys, '", "'))
    )
    print('"default" style is applied.')
    style = "default"
  end

  return styles[style]
end

return M

