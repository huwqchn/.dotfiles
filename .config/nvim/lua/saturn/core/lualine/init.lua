local M = {}
M.config = function()
  saturn.builtin.lualine = {
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
end

M.setup = function()
  if #vim.api.nvim_list_uis() == 0 then
    local Log = require "saturn.core.log"
    Log:debug "headless mode detected, skipping running setup for lualine"
    return
  end

  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  require("saturn.core.lualine.styles").update()

  lualine.setup(saturn.builtin.lualine)

  if saturn.builtin.lualine.on_config_done then
    saturn.builtin.lualine.on_config_done(lualine)
  end
end

return M
