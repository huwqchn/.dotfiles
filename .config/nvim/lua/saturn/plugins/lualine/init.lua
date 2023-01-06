local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
}

saturn.plugins.lualine = {
  active = true,
  style = "saturn",
  options = {
    icons_enabled = nil,
    component_separators = nil,
    section_separators = nil,
    theme = nil,
    disabled_filetypes = nil,
    globalstatus = true,
  },
  sections = {
    lualine_a = nil,
    lualine_b = nil,
    lualine_c = nil,
    lualine_x = nil,
    lualine_y = nil,
    lualine_z = nil,
  },
  inactive_sections = {
    lualine_a = nil,
    lualine_b = nil,
    lualine_c = nil,
    lualine_x = nil,
    lualine_y = nil,
    lualine_z = nil,
  },
  tabline = nil,
  extensions = nil,
  on_config_done = nil,
}

M.config = function()
  local lualine = require("lualine")

  require("saturn.plugins.lualine.styles").update()

  lualine.setup(saturn.plugins.lualine)

  if saturn.plugins.lualine.on_config_done then
    saturn.plugins.lualine.on_config_done(lualine)
  end
end

return M
