local M = {}
local components = require "saturn.plugins.core.lualine.components"

local styles = {
  saturn = nil,
  default = nil,
  none = nil,
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
    disabled_filetypes = { "alpha" },
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

function M.get_style(style)
  local style_keys = vim.tbl_keys(styles)
  if not vim.tbl_contains(style_keys, style) then
    local Log = require "saturn.plugins.core.log"
    Log:error(
      "Invalid lualine style"
        .. string.format('"%s"', style)
        .. "options are: "
        .. string.format('"%s"', table.concat(style_keys, '", "'))
    )
    Log:debug '"saturn" style is applied.'
    style = "saturn"
  end

  return vim.deepcopy(styles[style])
end

function M.update()
  local style = M.get_style(saturn.plugins.lualine.style)

  saturn.plugins.lualine = vim.tbl_deep_extend("keep", saturn.plugins.lualine, style)

  local color_template = vim.g.colors_name or saturn.colorscheme
  local theme_supported, template = pcall(function()
    require("lualine.utils.loader").load_theme(color_template)
  end)
  if theme_supported and template then
    saturn.plugins.lualine.options.theme = color_template
  end
end

return M

