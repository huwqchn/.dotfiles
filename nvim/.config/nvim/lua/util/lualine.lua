local M = {}
local Util = require("lazyvim.util")

function M.fg(name)
  return Util.ui.fg(name)
end

function M.bg(name)
  ---@type {foreground?:number}?
  ---@diagnostic disable-next-line: deprecated
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
  ---@diagnostic disable-next-line: undefined-field
  local bg = hl and (hl.bg or hl.background)
  return bg and { bg = string.format("#%06x", bg) } or nil
end

return M
