local map = LazyVim.safe_keymap_set
-- local map = vim.keymap.set
-- local LazyVim = require("lazyvim.util")

vim.keymap.set({ "n", "x", "o" }, "<S-h>", "^", { desc = "Go to first non-blank character of the line" })
vim.keymap.set({ "n", "x", "o" }, "<S-l>", "$", { desc = "Go to last non-blank character of the line" })

-- Resize window using <ctrl> arrow keys
map("n", "<A-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<A-j>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<A-k>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<A-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
-- new space line
-- map("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = "Put empty line above" })
-- map("n", "go", "<Cmd>call append(line('.'), repeat([''], v:count1))<CR>", { desc = "Put empty line below" })

-- swap windows with sn se si so
map("n", "sH", "<C-w>H", { desc = "swap with left", remap = true })
map("n", "sJ", "<C-w>J", { desc = "swap with below", remap = true })
map("n", "sK", "<C-w>K", { desc = "swap with above", remap = true })
map("n", "sL", "<C-w>L", { desc = "swap with right", remap = true })

-- other window keybindings
map("n", "<leader>wo", "<C-w>o", { desc = "Clear other windows" })

-- split the screens
map("n", "sk", function()
  vim.opt.splitbelow = false
  vim.cmd([[split]])
  vim.opt.splitbelow = true
end, { desc = "split above" })
map("n", "sj", function()
  vim.opt.splitbelow = true
  vim.cmd([[split]])
end, { desc = "split below" })
map("n", "sh", function()
  vim.opt.splitright = false
  vim.cmd([[vsplit]])
end, { desc = "split left" })
map("n", "sl", function()
  vim.opt.splitright = true
  vim.cmd([[vsplit]])
end, { desc = "split right" })

-- Rotate window
map("n", "<leader>wK", "<C-w>b<C-w>K", { desc = "rotate window up" })
map("n", "<leader>wH", "<C-w>b<C-w>H", { desc = "rotate window left" })

-- move current window to the far left, bottom, right, top
map("n", "<leader>wh", "<C-w>H", { desc = "move to the far left" })
map("n", "<leader>wj", "<C-w>J", { desc = "move to the far bottom" })
map("n", "<leader>wk", "<C-w>L", { desc = "move to the far right" })
map("n", "<leader>wl", "<C-w>K", { desc = "move to the far top" })
