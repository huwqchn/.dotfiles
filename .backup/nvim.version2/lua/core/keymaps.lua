local opts = { noremap = true, silent = true }
local re_opts = { remap = true, silent = true }

local keymap = vim.keymap.set

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

--map t/T to g/G
keymap("", "t", "g", re_opts)
keymap("", "T", "G", opts)

keymap("", "gt", "gg", opts)
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
keymap("", "L", "U", opts)

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

keymap("", "S", ":w<CR>", opts)
keymap("", "Q", ":q<CR>", opts)

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
