local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal
keymap("n", ";", ":", opts)

-- Press ` to change case
keymap("n", "`", "~", opts)

-- colemak mapping
-- Insert Key
keymap("n", "k", "i", opts)
keymap("n", "K", "I", opts)
-- Cursor Movement
--
-- New cursor movement (the default arrow keys are used for resizing windows)
--     ^
--     u
-- < n   i >
--     e
--     v

keymap("n", "u", "k", opts)
keymap("n", "n", "h", opts)
keymap("n", "e", "j", opts)
keymap("n", "i", "l", opts)

keymap("n", "gu", "gk", opts)
keymap("n", "ge", "gj", opts)

-- U/E keys for 5 times u/e (faster  navigation)
keymap("n", "U", "5k", opts)
keymap("n", "E", "5j", opts)

-- go to the start/end of the line
keymap("n", "N", "^", opts)
keymap("n", "I", "$", opts)

keymap("n", "h", "e", opts)

-- faster in-line navigation
keymap("n", "W", "5w", opts)
keymap("n", "B", "5b", opts)

-- Ctrl + U or E will move up/down the view port without moving the cursor
keymap("n", "<C-U>", "5<C-y>", opts)
keymap("n", "<C-E>", "5<C-e>", opts)


-- Undo operations
keymap("n", "l", "u", opts)

-- Indentation
keymap("n", "<", "<<", opts)
keymap("n", ">", ">>", opts)

-- Searching
keymap("n", "-", "N", opts)
keymap("n", "=", "n", opts)

-- make Y to copy till the end of the line
keymap("n", "Y", "y$", opts)

-- Cop; to system clipboard
keymap("v", "Y", '"+y', opts)

-- Leader Key
-- Window Management
keymap("n", "<LEADER>ww", "<C-w>w", opts)
keymap("n", "<LEADER>wu", "<C-w>k", opts)
keymap("n", "<LEADER>we", "<C-w>j", opts)
keymap("n", "<LEADER>wn", "<C-w>h", opts)
keymap("n", "<LEADER>wi", "<C-w>l", opts)
keymap("n", "<LEADER>wq", "<C-w>o", opts)

-- File Operation
keymap("n", "<LEADER>fs", ":w<CR>", opts)
keymap("n", "<LEADER>fq", ":q<CR>", opts)

keymap("n", "S", ":w<CR>", opts)
keymap("n", "Q", ":q<CR>", opts)

-- Select current line
keymap("n", "<LEADER>vv", "v$h", opts)
-- Paste and replace a word
keymap("n", "<LEADER>vw", "viwp", opts)

-- Delete find pair
keymap("n", "<LEADER>dp", "d%", opts)

-- split the screens to up(horizontal), down(horizontal), left(vertical),right(vertical)
keymap("n", "<LEADER>su", ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>", opts)
keymap("n", "<LEADER>se", ":set splitbelow<CR>:split<CR>", opts)
keymap("n", "<LEADER>sn", ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>", opts)
keymap("n", "<LEADER>si", ":set splitright<CR>:vsplit<CR>", opts)

-- Place the two screens up and down
keymap("n", "<LEADER>sh", "<C-w>t<C-w>K", opts)
keymap("n", "<LEADER>sv", "<C-w>t<C-w>H", opts)

-- find and replace
keymap("n", "<LEADER>sg", ":%s//g<left><left>", opts)

-- Resize splits
keymap("n", "<LEADER>ru", ":res +5<CR>", opts)
keymap("n", "<LEADER>re", ":res -5<CR>", opts)
keymap("n", "<LEADER>rn", ":vertical resize-5<CR>", opts)
keymap("n", "<LEADER>ri", ":vertical resize+5<CR>", opts)

-- Rotate screens
keymap("n", "<LEADER>rh", "<C-w>b<C-w>K", opts)
keymap("n", "<LEADER>rv", "<C-w>b<C-w>H", opts)

-- Tab Management
-- Create a new tab
keymap("n", "<LEADER>te", ":tabe<CR>", opts)
keymap("n", "<LEADER>tE", ":tab split<CR>", opts)

-- Move arount tabs
keymap("n", "<LEADER>tn", ":-tabnext<CR>", opts)
keymap("n", "<LEADER>ti", ":+tabnext<CR>", opts)

-- Move the tabs
keymap("n", "<LEADER>tN", ":-tabmove<CR>", opts)
keymap("n", "<LEADER>tI", ":+tabmove<CR>", opts)

-- Navigate buffers
keymap("n", "<LEADER>bn", ":bprevious<CR>", opts)
keymap("n", "<LEADER>bi", ":bnext<CR>", opts)

-- Move line up and down
keymap("n", "<A-u>", "<Esc>:m .-2<CR>==gi", opts)
keymap("n", "<A-e>", "<Esc>:m .+1<CR>==gi", opts)

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


