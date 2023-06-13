local map = vim.keymap.set

-- colemak-dh movement
map({ "n", "x" }, "e", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "i", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "n", "h")
map({ "n", "x" }, "o", "l")

-- colemak-dh jump to start/end of the line
map({ "n", "x" }, "N", "^")
map({ "n", "x" }, "O", "$")

-- colemak-dh join/hover
map({ "n", "x", "o" }, "I", "K")
map({ "n", "x", "o" }, "E", "J")

-- colemak-dh insert key
map({ "n", "x", "o" }, "h", "i")
map({ "n", "x", "o" }, "H", "I")
map({ "n", "x", "o" }, "gh", "gi", { desc = "goto last insert" })
map({ "n", "x", "o" }, "gH", "gI", { desc = "goto start of last insert line" })

-- colemake-dh undo key
map({ "n", "x", "o" }, "l", "o")
map({ "n", "x", "o" }, "L", "O")

-- colemak-dh end of word
map({ "n", "x", "o" }, "j", "e")
map({ "n", "x", "o" }, "J", "E")
map({ "n", "x", "o" }, "gj", "ge")
map({ "n", "x", "o" }, "gJ", "gE")

-- colemake searching key
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map({ "n", "x", "o" }, "k", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({ "n", "x", "o" }, "K", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map({ "n", "x", "o" }, "gk", "gn", { desc = "Search forwards and select" })
map({ "n", "x", "o" }, "gK", "gN", { desc = "Search backwards and select" })

-- colemak scroll
map({ "n", "v" }, "<C-m>", "<C-e>")

-- scroll window horizontally (scroll-horizontal)
-- < reference: https://unix.stackexchange.com/questions/110251/how-to-put-current-line-at-top-center-bottom-of-screen-in-vim
map("n", "[z", "zh", { desc = "scroll left", silent = true }) -- left
map("n", "]z", "zl", { desc = "scroll right", silent = true }) -- right

-- emacs kill a line
map("i", "<C-k>", "<cmd>normal! dd<cr>")

-- search work under cursor
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- clear search with <esc>
map({ "n", "i" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- better cmd mode
map("n", ":", ",")
-- map("n", "<cr>", ":")
-- backup cmd mode, some plugins will override <cr>
map("n", "\\", ":")
map("n", ",", ":")

-- quit
-- map("n", "Q", "<cmd>q<cr>")
map("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- select all
map({ "n", "x", "i" }, "<C-a>", "<cmd>normal! ggVG<cr>")

-- new space line
map("n", "<C-cr>", "<cmd>normal! o<cr>")

-- paste
map("i", "<C-v>", "<C-g>u<Cmd>set paste<CR><C-r>+<Cmd>set nopaste<CR>")
map("t", "<C-v>", "<C-\\><C-N>pi")
map("c", "<C-v>", "<C-r>+")

-- inc/dec number
map("n", "<C-=>", "<C-a>")
map("n", "<C-->", "<C-x>")

-- Column inc/dec numbers
map("v", "g<C-=>", "g<C-a>")
map("v", "g<C-->", "g<C-x>")

-- better indentation
map("n", "<", "<<")
map("n", ">", ">>")
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Better Copy
map("n", "Y", "y$")
map("v", "Y", '"+y')

-- Move lines
map("n", "<A-e>", "<cmd>m .+1<CR>==", { desc = "Move down" })
map("n", "<A-i>", "<cmd>m .-2<CR>==", { desc = "Move up" })
map("i", "<A-e>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move down" })
map("i", "<A-i>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move up" })
map("v", "<A-e>", ":m '>+1<CR>gv=gv", { desc = "Move down" })
map("v", "<A-i>", ":m '<-2<CR>gv=gv", { desc = "Move up" })

-- insert mode navigation
map("i", "<A-Up>", "<C-\\><C-N><C-w>k")
map("i", "<A-Down>", "<C-\\><C-N><C-w>j")
map("i", "<A-Left>", "<C-\\><C-N><C-w>h")
map("i", "<A-Right>", "<C-\\><C-N><C-w>l")

-- Terminal window navigation
map("t", "<C-n>", "<C-\\><C-N><C-w>h", { desc = "move to left" })
map("t", "<C-e>", "<C-\\><C-N><C-w>j", { desc = "move to down" })
map("t", "<C-i>", "<C-\\><C-N><C-w>k", { desc = "move to up" })
map("t", "<C-o>", "<C-\\><C-N><C-w>l", { desc = "move to right" })
map("t", "<C-q>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- map tab to tab, because distinguish between <C-i>
map("t", "<Tab>", "<Tab>")

-- navigate tab completion with <c-e> and <c-j>
-- runs conditionally
map("c", "<C-e>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
map("c", "<C-i>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })

-- colemak goto new position in jumplist
map("n", "<C-,>", "<C-i>")
map("n", "<C-.>", "<C-o>")

-- Windows managenment
--Better window movement
map("n", "<C-w>", "<C-w>w", { desc = "Switch window" })
map("n", "<C-n>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-e>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-i>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-o>", "<C-w>l", { desc = "Go to right window" })
map("n", "<C-l>", "<C-w>o", { desc = "Clear other windwos" })
map("n", "<C-q>", "<C-w>q", { desc = "Quit window" })

-- Resize with arrows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- disable the default s key
map({ "n", "x" }, "s", "<nop>", { desc = "split/surround/select" })

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

-- move current windwo to the far left, bottom, right, top
map("n", "<leader>wn", "<C-w>H", { desc = "move to the far left" })
map("n", "<leader>we", "<C-w>J", { desc = "move to the far bottom" })
map("n", "<leader>wo", "<C-w>L", { desc = "move to the far right" })
map("n", "<leader>wi", "<C-w>K", { desc = "move to the far top" })

-- Switch buffer with tab
map("n", "<tab>", "<cmd>bnext<cr>")
map("n", "<s-tab>", "<cmd>bprevious<cr>")

-- Tabs management
map("n", "]<tab>", "<cmd>tabn<CR>", { desc = "Next Tab" })
map("n", "[<tab>", "<cmd>tabp<CR>", { desc = "Prev Tab" })
map("n", "<leader><tab>s", "<cmd>tab split<CR>", { desc = "Split" })
map("n", "<leader><tab>]", "<cmd>-tabmove<CR>", { desc = "Move to left" })
map("n", "<leader><tab>[", "<cmd>+tabmove<CR>", { desc = "Move to right" })
map("n", "<leader><tab>o", "<cmd>tabonly<CR>", { desc = "Close all other tabs" })
map("n", "<leader><tab>F", "<cmd>tabm 0<CR>", { desc = "Move to first" })
map("n", "<leader><tab>L", "<cmd>tabm<CR>", { desc = "Move to last" })
map("n", "<leader><tab>t", "<cmd>tabs", { desc = "List all tabs" })

-- Replace in selection
map("x", "ss", ":s/\\%V", { desc = "replace in selection" })

-- lazy
map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
-- smart deletion, dd
-- It solves the issue, where you want to delete empty line, but dd will override you last yank.
-- Code above will check if u are deleting empty line, if so - use black hole register.
-- [src: https://www.reddit.com/r/neovim/comments/w0jzzv/comment/igfjx5y/?utm_source=share&utm_medium=web2x&context=3]
local function smart_dd()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_dd'
	else
		return "dd"
	end
end
vim.keymap.set("n", "dd", smart_dd, { noremap = true, expr = true })
