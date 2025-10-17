local M = {}

M.name = (vim.env.KEYBOARD_LAYOUT or "colemak"):lower()

---@param value string
---@return boolean
function M.is(value)
  return M.name == value:lower()
end

function M.is_colemak()
  return M.is("colemak")
end

function M.is_qwerty()
  return M.is("qwerty")
end

return M
