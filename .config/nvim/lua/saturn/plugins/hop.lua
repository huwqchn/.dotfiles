local M = {
  "phaazon/hop.nvim",
  branch = "v2",
  enabled = saturn.enable_extra_plugins,
  keys = {
    { "j", ":HopPattern<cr>", silent = true },
    { "<leader>j", ":HopChar2<cr>", silent = true, desc = "Jump" },
    {
      "f",
      ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<CR>",
      mode = "o",
      noremap = true,
      silent = true,
    },
    {
      "F",
      ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<CR>",
      mode = "o",
      noremap = true,
      silent = true,
    },
    {
      "t",
      ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<CR>",
      mode = "o",
      noremap = true,
      silent = true,
    },
    {
      "T",
      ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<CR>",
      mode = "o",
      noremap = true,
      silent = true,
    },
    {
      "f",
      ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<CR>",
      mode = "n",
      noremap = true,
      silent = true,
    },
    {
      "F",
      ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<CR>",
      mode = "n",
      noremap = true,
      silent = true,
    },
    {
      "t",
      ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<CR>",
      mode = "n",
      noremap = true,
      silent = true,
    },
    {
      "T",
      ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<CR>",
      mode = "n",
      noremap = true,
      silent = true,
    },
  },
}

M.config = function()
  require("hop").setup({ keys = "arstdhneoioqwfplukmcxzv" })
end

return M
