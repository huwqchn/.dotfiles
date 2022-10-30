local M = {}

function M.load()
  vim.keymap.set("", 
    saturn.leaderkey, "<Nop>", 
    { noremap = true, silent = true })
  vim.g.mapleader = saturn.leaderkey
  vim.g.maplocalleader = saturn.leaderkey
	require('saturn.core.keymaps.general').load()
end

return M
