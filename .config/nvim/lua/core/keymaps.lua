local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--	 normal_mode = "n",
--	 insert_mode = "i",
--	 visual_mode = "v",
--	 visual_block_mode = "x",
--	 term_mode = "t",
--	 command_mode = "c",

keymap("", ";", ":", opts)

-- Press ` to change case
keymap("", "`", "~", opts)

-- colemak mapping
-- Insert Key
keymap("", "k", "i", opts)
keymap("", "K", "I", opts)
-- Cursor Movement
--
-- New cursor movement (the default arrow keys are used for resizing windows)
--		 ^
--		 u
-- < n	 i >
--		 e
--		 v

keymap("", "u", "k", opts)
keymap("", "n", "h", opts)
keymap("", "e", "j", opts)
keymap("", "i", "l", opts)

keymap("", "gu", "gk", opts)
keymap("", "ge", "gj", opts)

-- U/E keys for 5 times u/e (faster	navigation)
keymap("", "U", "5k", opts)
keymap("", "E", "5j", opts)

-- go to the start/end of the line
keymap("", "N", "^", opts)
keymap("", "I", "$", opts)

keymap("", "h", "e", opts)
keymap("", "H", "E", opts)

-- faster in-line navigation
keymap("", "W", "5w", opts)
keymap("", "B", "5b", opts)

-- Ctrl + U or E will move up/down the view port without moving the cursor
keymap("", "<C-U>", "5<C-y>", opts)
keymap("", "<C-E>", "5<C-e>", opts)


-- Undo operations
keymap("", "l", "u", opts)

-- Indentation
keymap("n", "<", "<<", opts)
keymap("n", ">", ">>", opts)

-- Searching
keymap("", "-", "N", opts)
keymap("", "=", "n", opts)

-- make Y to copy till the end of the line
keymap("n", "Y", "y$", opts)

-- Cop; to system clipboard
keymap("v", "Y", '"+y', opts)

-- Leader Key
-- Window Management
keymap("", "<LEADER>ww", "<C-w>w", opts)
keymap("", "<LEADER>wu", "<C-w>k", opts)
keymap("", "<LEADER>we", "<C-w>j", opts)
keymap("", "<LEADER>wn", "<C-w>h", opts)
keymap("", "<LEADER>wi", "<C-w>l", opts)
keymap("", "<LEADER>wq", "<C-w>o", opts)

-- File Operation
keymap("", "<LEADER>fs", ":w<CR>", opts)
keymap("", "<LEADER>fq", ":q<CR>", opts)

keymap("", "S", ":w<CR>", opts)
keymap("", "Q", ":q<CR>", opts)

-- Select current line
keymap("", "<LEADER>vv", "v$h", opts)
-- Paste and replace a word
keymap("n", "<LEADER>vw", "viwp", opts)

-- Delete find pair
keymap("n", "<LEADER>dp", "d%", opts)

-- split the screens to up(horizontal), down(horizontal), left(vertical),right(vertical)
keymap("", "<LEADER>su", ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>", opts)
keymap("", "<LEADER>se", ":set splitbelow<CR>:split<CR>", opts)
keymap("", "<LEADER>sn", ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>", opts)
keymap("", "<LEADER>si", ":set splitright<CR>:vsplit<CR>", opts)

-- Place the two screens up and down
keymap("", "<LEADER>sh", "<C-w>t<C-w>K", opts)
keymap("", "<LEADER>sv", "<C-w>t<C-w>H", opts)

-- find and replace
keymap("", "<LEADER>sg", ":%s//g<left><left>", opts)

-- Resize splits
keymap("", "<LEADER>ru", ":res +5<CR>", opts)
keymap("", "<LEADER>re", ":res -5<CR>", opts)
keymap("", "<LEADER>rn", ":vertical resize-5<CR>", opts)
keymap("", "<LEADER>ri", ":vertical resize+5<CR>", opts)

-- Rotate screens
keymap("", "<LEADER>rh", "<C-w>b<C-w>K", opts)
keymap("", "<LEADER>rv", "<C-w>b<C-w>H", opts)

-- Tab Management
-- Create a new tab
keymap("", "<LEADER>te", ":tabe<CR>", opts)
keymap("", "<LEADER>tE", ":tab split<CR>", opts)

-- Move arount tabs
keymap("", "<LEADER>tn", ":-tabnext<CR>", opts)
keymap("", "<LEADER>ti", ":+tabnext<CR>", opts)

-- Move the tabs
keymap("", "<LEADER>tN", ":-tabmove<CR>", opts)
keymap("", "<LEADER>tI", ":+tabmove<CR>", opts)

-- Navigate buffers
keymap("", "<LEADER>bn", ":bprevious<CR>", opts)
keymap("", "<LEADER>bi", ":bnext<CR>", opts)

-- Move line up and down
keymap("", "<A-u>", "<Esc>:m .-2<CR>==gi", opts)
keymap("", "<A-e>", "<Esc>:m .+1<CR>==gi", opts)

-- Visual
-- Move text up and down
keymap("v", "<A-u>", ":m .-2<CR>==", opts)
keymap("v", "<A-e>", ":m .+1<CR>==", opts)

-- Command Mode CUrsor Movement
keymap("c", "<C-h>", "<Home>", opts)
keymap("c", "<C-o>", "<End>", opts)
keymap("c", "<C-u>", "<Up>", opts)
keymap("c", "<C-e>", "<Down>", opts)
keymap("c", "<C-n>", "<Left>", opts)
keymap("c", "<C-i>", "<Right>", opts)
keymap("c", "<C-s>", "<S-Left>", opts)
keymap("c", "<C-t>", "<S-Right>", opts)


