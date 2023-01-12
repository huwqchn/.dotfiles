-- colemak movement
vim.keymap.set("", "e", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("", "u", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("", "n", "h")
vim.keymap.set("", "i", "l")
vim.keymap.set("", "gu", "gk")
vim.keymap.set("", "ge", "gj")

-- colemak jump to start/end of the line
vim.keymap.set("", "N", "^")
vim.keymap.set("", "I", "$")
-- colemak fast navigation
vim.keymap.set("", "U", "<C-b>")
vim.keymap.set("", "E", "<C-f>")

-- colemak insert key
vim.keymap.set("", "k", "i", { remap = true })
vim.keymap.set("", "K", "I", { remap = true })

-- colemake undo key
vim.keymap.set("", "l", "u")
vim.keymap.set("", "L", "U")

-- colemak end of word
vim.keymap.set("", "h", "e")
vim.keymap.set("", "H", "E")

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
vim.keymap.set("n", "<A-u>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-u>", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<A-u>", "<Esc>:m .-2<CR>==gi")

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
vim.keymap.set("t", "<C-u>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-i>", "<C-\\><C-N><C-w>l")

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", {desc = "Enter Normal Mode"})
-- navigate tab completion with <c-j> and <c-k>
-- runs conditionally
vim.keymap.set("c", "<C-e>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
vim.keymap.set("c", "<C-u>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })

-- goto new position in jumplist
vim.keymap.set("n", "<C-h>", "<C-i>")

-- Windows managenment
--Better window movement
vim.keymap.set("n", "<C-w>", "<C-w>w")
vim.keymap.set("n", "<C-x>", "<C-w>x")
vim.keymap.set("n", "<C-n>", "<C-w>h")
vim.keymap.set("n", "<C-e>", "<C-w>j")
vim.keymap.set("n", "<C-u>", "<C-w>k")
vim.keymap.set("n", "<C-i>", "<C-w>l")
vim.keymap.set("n", "<C-l>", "<C-w>o")

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>")

-- disable the default s key
vim.keymap.set("n", "s", "<nop>")

-- split the screens
vim.keymap.set("n", "su", ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>", { desc = "split above"})
vim.keymap.set("n", "se", ":set splitbelow<CR>:split<CR>", { desc = "split below"})
vim.keymap.set("n", "sn", ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>", { desc = "split left"})
vim.keymap.set("n", "si", ":set splitright<CR>:vsplit<CR>", { desc = "split right"})

-- Rotate window
vim.keymap.set("n", "<leader>wU", "<C-w>b<C-w>K", { desc = "rotate window up"})
vim.keymap.set("n", "<leader>wN", "<C-w>b<C-w>H", { desc = "rotate window left"})

vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "other-window" })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "delete-window" })
-- move current windwo to the far left, bottom, right, top
vim.keymap.set("n", "<leader>wn", "<C-w>H", { desc = "move to the far left"})
vim.keymap.set("n", "<leader>we", "<C-w>J", { desc = "move to the far bottom"})
vim.keymap.set("n", "<leader>wi", "<C-w>L", { desc = "move to the far right"})
vim.keymap.set("n", "<leader>wu", "<C-w>K", { desc = "move to the far top"})

-- Tabs management
vim.keymap.set("n", "<leader><tab>a", "<cmd>tabfirst<CR>", { desc = "First" })
vim.keymap.set("n", "<leader><tab>z", "<cmd>tablast<CR>", { desc = "Last" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "New Tab" })
vim.keymap.set("n", "]<tab>", "<cmd>tabn<CR>", { desc = "Next" })
vim.keymap.set("n", "[<tab>", "<cmd>tabp<CR>", { desc = "Previous"})
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<CR>", { desc = "Close" })
vim.keymap.set("n", "<leader><tab>s", "<cmd>tab split<CR>", { desc = "Split" })
vim.keymap.set("n", "<leader><tab>N", "<cmd>-tabmove<CR>", { desc = "Move to left" })
vim.keymap.set("n", "<leader><tab>I", "<cmd>+tabmove<CR>", { desc = "Move to right" })
vim.keymap.set("n", "<leader><tab>l", "<cmd>tabonly<CR>", { desc = "Close all other tabs" })
vim.keymap.set("n", "<leader><tab>A", "<cmd>tabm 0<CR>", { desc = "Move to first" })
vim.keymap.set("n", "<leader><tab>Z", "<cmd>tabm<CR>", { desc = "Move to last" })
vim.keymap.set("n", "<leader><tab>t", "<cmd>tabs", { desc = "List all tabs" })

-- buffers
vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>`", "<cmd>:e #<cr>", { desc = "Switch to Other Buffer" })
