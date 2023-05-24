-- colemak movement
vim.keymap.set("", "e", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("", "i", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("", "n", "h")
vim.keymap.set("", "o", "l") -- for mini.ai case
vim.keymap.set("", "gi", "gk")
vim.keymap.set("", "ge", "gj")

-- colemak jump to start/end of the line
vim.keymap.set("", "N", "^")
vim.keymap.set("", "O", "$")
-- colemak fast navigation
vim.keymap.set("", "I", "<C-b>")
vim.keymap.set("", "E", "<C-f>")

-- colemak insert key
vim.keymap.set("", "h", "i")
vim.keymap.set("", "H", "I")

-- colemake undo key
-- vim.keymap.set("", "l", "u")
-- vim.keymap.set("", "L", "U")

-- colemak end of word
vim.keymap.set("", "k", "e")
-- vim.keymap.set("", "H", "K")

-- colemake searching key
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("", "=", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("", "-", "'nN'[v:searchforward]", { expr = true })

-- clear search with <esc>
vim.keymap.set({ "n", "i" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- save
vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>wa<cr><esc>")
vim.keymap.set("", "S", "<cmd>w<cr><esc>")

-- quit
vim.keymap.set("", "<C-q>", "<cmd>qa<cr>")
vim.keymap.set("", "Q", "<cmd>q<cr>")

-- select all
vim.keymap.set("", "<C-a>", "<esc>ggVG")

-- paste
vim.keymap.set("i", "<C-v>", "<C-g>u<Cmd>set paste<CR><C-r>+<Cmd>set nopaste<CR>")
vim.keymap.set("t", "<C-v>", "<C-\\><C-N>pi")
vim.keymap.set("c", "<C-v>", "<C-r>+")

-- inc/dec number
vim.keymap.set("", "<C-=>", "<C-a>")
vim.keymap.set("", "<C-->", "<C-x>")

-- Column inc/dec numbers
vim.keymap.set("v", "g<C-=>", "g<C-a>")
vim.keymap.set("v", "g<C-->", "g<C-x>")

-- better indentation
vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Better Copy
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("v", "Y", '"+y')

-- Move lines
vim.keymap.set("n", "<A-e>", ":m .+1<CR>==")
vim.keymap.set("v", "<A-e>", ":m '>+1<CR>gv=gv")
vim.keymap.set("i", "<A-e>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("n", "<A-i>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-i>", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<A-i>", "<Esc>:m .-2<CR>==gi")

-- Switch buffer with tab
vim.keymap.set("n", "<tab>", "<cmd>bnext<cr>")
vim.keymap.set("n", "<s-tab>", "<cmd>bprevious<cr>")

-- Replace in selection
vim.keymap.set("n", "s", "<cmd>s/\\%V")

-- insert mode navigation
vim.keymap.set("i", "<A-Up>", "<C-\\><C-N><C-w>k")
vim.keymap.set("i", "<A-Down>", "<C-\\><C-N><C-w>j")
vim.keymap.set("i", "<A-Left>", "<C-\\><C-N><C-w>h")
vim.keymap.set("i", "<A-Right>", "<C-\\><C-N><C-w>l")

-- Terminal window navigation
vim.keymap.set("t", "<C-n>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-e>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-i>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-o>", "<C-\\><C-N><C-w>l")

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
-- navigate tab completion with <c-j> and <c-k>
-- runs conditionally
vim.keymap.set("c", "<C-e>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
vim.keymap.set("c", "<C-i>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })

-- goto new position in jumplist
-- vim.keymap.set("n", "<C-h>", "<C-i>")

-- Windows managenment
--Better window movement
vim.keymap.set("n", "<C-w>", "<C-w>w")
vim.keymap.set("n", "<C-x>", "<C-w>x")
vim.keymap.set("n", "<C-n>", "<C-w>h")
vim.keymap.set("n", "<C-e>", "<C-w>j")
vim.keymap.set("n", "<C-i>", "<C-w>k")
vim.keymap.set("n", "<C-o>", "<C-w>l")
vim.keymap.set("n", "<C-l>", "<C-w>o")

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>")

-- disable the default s key
vim.keymap.set("n", "s", "<nop>")

-- split the screens
vim.keymap.set("n", "si", ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>", { desc = "split above" })
vim.keymap.set("n", "se", ":set splitbelow<CR>:split<CR>", { desc = "split below" })
vim.keymap.set("n", "sn", ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>", { desc = "split left" })
vim.keymap.set("n", "so", ":set splitright<CR>:vsplit<CR>", { desc = "split right" })
