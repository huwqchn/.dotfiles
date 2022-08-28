local status_ok, navigator = pcall(require, "Navigator")
if not status_ok then
  return
end

navigator.setup()
local keymap = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
-- tmux navigation
keymap("n", "<C-h>", "<cmd>lua require('Navigator').left()<CR>", opt)
keymap("n", "<C-k>", "<cmd>lua require('Navigator').up()<CR>", opt)
keymap("n", "<C-l>", "<cmd>lua require('Navigator').right()<CR>", opt)
keymap("n", "<C-j>", "<cmd>lua require('Navigator').down()<CR>", opt)
