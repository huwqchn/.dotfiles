--          Mode  | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang |
-- Command        +------+-----+-----+-----+-----+-----+------+------+
-- [nore]map      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |
-- n[nore]map     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |
-- [nore]map!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |
-- i[nore]map     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |
-- c[nore]map     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |
-- v[nore]map     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |
-- x[nore]map     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |
-- s[nore]map     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |
-- o[nore]map     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |
-- t[nore]map     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |
-- l[nore]map     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |
-- HACK: very careful with this
local map = LazyVim.safe_keymap_set
local unmap = vim.keymap.del
unmap("n", "<C-h>")
unmap("n", "<C-j>")
unmap("n", "<C-k>")
unmap("n", "<C-l>")

-- local map = vim.keymap.set
-- local LazyVim = require("lazyvim.util")
-- colemak-dh movement
map({ "n", "x" }, "e", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "i", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "n", "h", { desc = "Left", silent = true })
map({ "n", "x" }, "o", "l", { desc = "Left", silent = true })

-- colemak-dh jump to start/end of the line
map({ "n", "x", "o" }, "N", "^")
map({ "n", "x", "o" }, "O", "$")
map({ "n", "x", "o" }, "gn", "gh")
map({ "n", "x", "o" }, "gN", "gH")

-- colemak-dh join/hover
map("n", "I", "K")
map("n", "E", "J")

-- colemak-dh insert key
map({ "n", "x", "o" }, "h", "i")
vim.keymap.set({ "x", "o" }, "hi", function()
  Snacks.scope.textobject({
    min_size = 2, -- minimum size of the scope
    edge = false, -- inner scope
    cursor = false,
    treesitter = { blocks = { enabled = false } },
  })
end, { silent = true, desc = "inner scope" })
vim.keymap.set({ "x", "o" }, "ai", function()
  Snacks.scope.textobject({
    cursor = false,
    min_size = 2, -- minimum size of the scope
    treesitter = { blocks = { enabled = false } },
  })
end, { silent = true, desc = "full scope" })

vim.keymap.set({ "n", "x", "o" }, "[i", function()
  Snacks.scope.jump({
    min_size = 1, -- allow single line scopes
    bottom = false,
    cursor = false,
    edge = true,
    treesitter = { blocks = { enabled = false } },
  })
end, { silent = true, desc = "jump to top edge of scope" })
vim.keymap.set({ "n", "x", "o" }, "]i", function()
  Snacks.scope.jump({
    min_size = 1, -- allow single line scopes
    bottom = true,
    cursor = false,
    edge = true,
    treesitter = { blocks = { enabled = false } },
  })
end, { silent = true, desc = "jump to bottom edge of scope" })
vim.keymap.set({ "n", "x", "o" }, "H", "I")
map({ "n", "x", "o" }, "gh", "gi", { desc = "goto last insert" })
map({ "n", "x", "o" }, "gH", "gI", { desc = "goto start of last insert line" })

-- colemake-dh undo key
vim.keymap.set({ "n", "x", "o" }, "l", "o")
vim.keymap.set({ "n", "x", "o" }, "L", "O")

-- colemak-dh end of word
map({ "n", "x", "o" }, "j", "e")
map({ "n", "x", "o" }, "gj", "ge")
map({ "n", "x", "o" }, "J", "E")
map({ "n", "x", "o" }, "gJ", "gE")

-- colemak-dh searching key
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "k", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "k", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "k", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "K", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "K", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "K", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

map({ "n", "x", "o" }, "gk", "gn", { desc = "Search forwards and select" })
map({ "n", "x", "o" }, "gK", "gN", { desc = "Search backwards and select" })

-- colemak scroll
map({ "n", "v" }, "<C-j>", "<C-e>")

-- new space line
map("n", "sL", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = "Put empty line above" })
map("n", "sl", "<Cmd>call append(line('.'), repeat([''], v:count1))<CR>", { desc = "Put empty line below" })

-- Terminal window navigation
map("t", "<C-n>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-e>", "<cmd>wincmd j<cr>", { desc = "Go to Down Window" })
map("t", "<C-i>", "<cmd>wincmd k<cr>", { desc = "Go to Up Window" })
map("t", "<C-o>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })

-- navigate tab completion with <c-e> and <c-j>
-- runs conditionally
map("c", "<C-e>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
map("c", "<C-i>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })

-- colemak goto new position in jumplist
map("n", "<C-h>", "<C-i>")
map("n", "<C-l>", "<C-o>")

-- Windows management
-- Better window movement
-- navigate window
map("n", "<C-n>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-e>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-i>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-o>", "<C-w>l", { desc = "Go to right window" })

-- Resize with arrows
map("n", "<A-n>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<A-e>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<A-i>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<A-o>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- swap windows with sn se si so
map("n", "sN", "<C-w>H", { desc = "swap with left" })
map("n", "sE", "<C-w>J", { desc = "swap with below" })
map("n", "sI", "<C-w>K", { desc = "swap with above" })
map("n", "sO", "<C-w>L", { desc = "swap with right" })

-- other window keybindings
map("n", "<C-k>", "<C-w>o", { desc = "Clear other windows" })

-- split the screens
map("n", "si", function()
  vim.opt.splitbelow = false
  vim.cmd([[split]])
  vim.opt.splitbelow = true
end, { desc = "split above" })
map("n", "se", function()
  vim.opt.splitbelow = true
  vim.cmd([[split]])
end, { desc = "split below" })
map("n", "sn", function()
  vim.opt.splitright = false
  vim.cmd([[vsplit]])
end, { desc = "split left" })
map("n", "so", function()
  vim.opt.splitright = true
  vim.cmd([[vsplit]])
end, { desc = "split right" })

-- Rotate window
map("n", "<leader>wI", "<C-w>b<C-w>K", { desc = "rotate window up" })
map("n", "<leader>wN", "<C-w>b<C-w>H", { desc = "rotate window left" })

-- move current window to the far left, bottom, right, top
map("n", "<leader>wn", "<C-w>H", { desc = "move to the far left" })
map("n", "<leader>we", "<C-w>J", { desc = "move to the far bottom" })
map("n", "<leader>wo", "<C-w>L", { desc = "move to the far right" })
map("n", "<leader>wi", "<C-w>K", { desc = "move to the far top" })

-- commenting
unmap("n", "gco")
unmap("n", "gcO")
map("n", "gcl", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcL", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })
