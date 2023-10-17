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
local Util = require("lazyvim.util")
local map = Util.safe_keymap_set
local unmap = vim.keymap.del
unmap("n", "<C-h>")
unmap("n", "<C-j>")
unmap("n", "<C-k>")
unmap("n", "<C-l>")
-- local map = vim.keymap.set
-- local Util = require("lazyvim.util")
-- colemak-dh movement
map({ "n", "x", "o" }, "e", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x", "o" }, "i", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x", "o" }, "n", "h")
map({ "n", "x", "o" }, "o", "l")

-- colemak-dh jump to start/end of the line
map({ "n", "x", "o" }, "N", "^")
map({ "n", "x", "o" }, "O", "$")

-- colemak-dh join/hover
-- map({ "n", "x", "o" }, "I", "K")
map("n", "E", "J")

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
map({ "n", "x", "o" }, "gj", "ge")
map({ "n", "x", "o" }, "J", "E")
map({ "n", "x", "o" }, "gJ", "gE")

-- colemak-dh searching key
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "k", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "k", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "k", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "K", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "K", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "K", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

map({ "n", "x", "o" }, "gk", "gn", { desc = "Search forwards and select" })
map({ "n", "x", "o" }, "gK", "gN", { desc = "Search backwards and select" })

-- colemak scroll
map({ "n", "v" }, "<C-j>", "<C-e>")

-- emacs delete end of line
map("i", "<C-k>", "<cmd>normal! d$<cr>", { silent = true, desc = "delete to end of line" })

-- emacs kill a whole line
map("i", "<M-x>", "<cmd>normal! dd<cr>", { silent = true, desc = "kill the whole line" })

-- emacs delete next word
map("i", "<M-d>", "<cmd>normal! dw<cr>", { silent = true, desc = "delete next word" })

-- emacs forward/backward word
map("i", "<M-f>", "<C-Right>", { silent = true, desc = "forward word" })
map("i", "<M-b>", "<C-Left>", { silent = true, desc = "backward word" })

-- emacs begin/end of line
-- map("i", "<C-a>", "<Home>", { silent = true, desc = "begin of line" })
-- map("i", "<C-e>", "<End>", { silent = true, desc = "end of line" })

-- autocorrect spelling from previous error
-- map("i", "<C-f>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { expr = true, silent = true })

-- better cmd mode, swap ; and :
map("", "<cr>", ":", { silent = false })

-- emacs style cmd mode keybindings for backup
map("", "<M-x>", ":", { silent = false })

map({ "n", "x", "o" }, ",", ":")
map({ "n", "x", "o" }, ":", ",")
map("", "g:", "g,")

-- select all
map({ "n", "x", "i" }, "<C-a>", "<cmd>normal! ggVG<cr>")

-- new space line
map("n", "<C-cr>", "<cmd>normal! o<cr>k")

-- paste
map("i", "<C-v>", "<C-g>u<Cmd>set paste<CR><C-r>+<Cmd>set nopaste<CR>")
map("t", "<C-v>", "<C-\\><C-N>pi")
map("c", "<C-v>", "<C-r>+")

-- inc/dec number
map({ "n", "v" }, "<C-=>", "<C-a>")
map({ "n", "v" }, "<C-->", "<C-x>")
map({ "n", "v" }, "g<C-=>", "g<C-a>")
map({ "n", "v" }, "g<C-->", "g<C-x>")

-- Move lines
unmap({ "n", "i", "x" }, "<A-k>")
unmap({ "n", "i", "x" }, "<A-j>")
map("n", "<A-e>", "<cmd>m .+1<CR>==", { desc = "Move down" })
map("n", "<A-i>", "<cmd>m .-2<CR>==", { desc = "Move up" })
map("i", "<A-e>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move down" })
map("i", "<A-i>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move up" })
map("x", "<A-e>", ":m '>+1<CR>gv=gv", { desc = "Move down" })
map("x", "<A-i>", ":m '<-2<CR>gv=gv", { desc = "Move up" })

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
local lazyterm = function()
  Util.float_term(nil, { cwd = Util.get_root() })
end
map("n", "<M-/>", lazyterm, { desc = "Terminal (root dir)" })
map("t", "<M-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- map tab to tab, because distinguish between <C-i>
map("t", "<Tab>", "<Tab>")

-- navigate tab completion with <c-e> and <c-j>
-- runs conditionally
map("c", "<C-e>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
map("c", "<C-i>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })

-- colemak goto new position in jumplist
map("n", "<C-h>", "<C-i>")
map("n", "<C-l>", "<C-o>")

-- scroll window horizontally (scroll-horizontal)
-- < reference: https://unix.stackexchange.com/questions/110251/how-to-put-current-line-at-top-center-bottom-of-screen-in-vim
map("n", "[z", "zh", { desc = "scroll left", silent = true }) -- left
map("n", "]z", "zl", { desc = "scroll right", silent = true }) -- right

-- Windows managenment
--Better window movement
-- naviagate window
map("n", "<C-n>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-e>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-i>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-o>", "<C-w>l", { desc = "Go to right window" })

-- swap windows with sn se si so
map("n", "sN", "<C-w>H", { desc = "swap with left" })
map("n", "sE", "<C-w>J", { desc = "swap with below" })
map("n", "sI", "<C-w>K", { desc = "swap with above" })
map("n", "sO", "<C-w>L", { desc = "swap with right" })

-- Resize with arrows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- other window keybindings
map("n", "<C-k>", "<C-w>o", { desc = "Clear other windwos" })
map("n", "<C-x>", "<C-w>x", { desc = "Exchange window" })
map("n", "<C-q>", function()
  -- close current window if there are more than 1 window
  -- else close current tab if there are more than 1 tab
  -- else close current vim
  if #vim.api.nvim_tabpage_list_wins(0) > 1 then
    vim.cmd([[close]])
  elseif #vim.api.nvim_list_tabpages() > 1 then
    vim.cmd([[tabclose]])
  else
    vim.cmd([[qa]])
  end
end, { desc = "Super Quit" })

-- Resize with arrows
map("n", "s<Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "s<Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "s<Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "s<Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

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
vim.keymap.set("n", "<tab>", "<cmd>bnext<cr>") -- confilct with <C-i>
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

-- close unused buffers
local id = vim.api.nvim_create_augroup("startup", {
  clear = false,
})

local persistbuffer = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  vim.fn.setbufvar(bufnr, "bufpersist", 1)
end

vim.api.nvim_create_autocmd({ "BufRead" }, {
  group = id,
  pattern = { "*" },
  callback = function()
    vim.api.nvim_create_autocmd({ "InsertEnter", "BufModifiedSet" }, {
      buffer = 0,
      once = true,
      callback = function()
        persistbuffer()
      end,
    })
  end,
})

map("n", "<leader>b<space>", function()
  local curbufnr = vim.api.nvim_get_current_buf()
  local buflist = vim.api.nvim_list_bufs()
  for _, bufnr in ipairs(buflist) do
    if vim.bo[bufnr].buflisted and bufnr ~= curbufnr and (vim.fn.getbufvar(bufnr, "bufpersist") ~= 1) then
      vim.cmd("bd " .. tostring(bufnr))
    end
  end
end, { silent = true, desc = "Close unused buffers" })

-- Replace in selection
map("x", "s<cr>", ":s/\\%V", { silent = false, desc = "replace in selection" })

-- toggle coloroclumn
map("n", "<leader>uo", function()
  require("util").toggle_colorcolumn()
end, { desc = "Toggle colorcolumn" })

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

if vim.fn.executable("btop") == 1 and not Util.has("toggleterm.nvim") then
  -- btop
  map("n", "<leader>xb", function()
    Util.float_term({ "btop" })
  end, { desc = "btop" })
end

-- change word with <c-c>
vim.keymap.set("n", "<C-c>", "<cmd>normal! ciw<cr>a")
