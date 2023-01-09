local M = {
  "phaazon/hop.nvim",
  branch = "v2",
  enabled = saturn.enable_extra_plugins,
  event = "VeryLazy",
}

M.config = function()
  local hop = require("hop")
  hop.setup({ keys = "arstdhneoioqwfplukmcxzv" })
  local directions = require("hop.hint").HintDirection
  vim.keymap.set("", "j", ":HopPattern<cr>", { silent = true })
  vim.keymap.set("", "<leader>j", ":HopChar2<cr>", { silent = true, desc = "Jump" })
  vim.keymap.set("", "f", function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
  end, { remap = true })
  vim.keymap.set("", "F", function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
  end, { remap = true })
  vim.keymap.set("", "t", function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
  end, { remap = true })
  vim.keymap.set("", "T", function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
  end, { remap = true })
end

return M
