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
local Util = require("saturn.utils.plugin")

local map = vim.keymap.set

-- colemak movement
map({ "n", "x", "o" }, "e", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x", "o" }, "u", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x", "o" }, "n", "h")
map({ "n", "x", "o" }, "i", "l")

-- colemak jump to start/end of the line
map({ "n", "x", "o" }, "N", "^")
map({ "n", "x", "o" }, "I", "$")

-- colemak fast navigation
map({ "n", "x", "o" }, "U", "5k")
map({ "n", "x", "o" }, "E", "5j")

-- colemak insert key
map({ "n", "x", "o" }, "k", "i")
map({ "n", "x", "o" }, "K", "I")
map({ "n", "x", "o" }, "gk", "gi", { desc = "goto last insert" })

-- colemake undo key
map({ "n", "x", "o" }, "l", "u")
map({ "n", "x", "o" }, "L", "U")

-- colemak end of word
map({ "n", "x", "o" }, "h", "e")
map({ "n", "x", "o" }, "H", "K")

-- colemake searching key
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map({ "n", "x", "o" }, "=", "'Nn'[v:searchforward]", { expr = true })
map({ "n", "x", "o" }, "-", "'nN'[v:searchforward]", { expr = true })

-- search work under cursor
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- clear search with <esc>
map({ "n", "i" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- better cmd mode
map({ "n", "x", "o" }, ":", ",")
map({ "n", "x", "o" }, "<cr>", ":")

-- backup cmd mode, some plugins will override <cr>
map({ "n", "x", "o" }, "\\", ":")

-- save
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>wa<cr><esc>", { desc = "Save all files" })
map("n", "S", "<cmd>w<cr>", { desc = "Save file" })

-- quit
-- map("n", "Q", "<cmd>q<cr>")
map("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })

-- select all
map({ "n", "x", "i" }, "<C-a>", "<cmd>normal! ggVG<cr>")

-- new space line
map("n", "<C-cr>", "o<esc>")
map("i", "<C-e>", "<esc>o")
map("i", "<C-u>", "<esc>O")

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
map("n", "<A-e>", ":m .+1<CR>==")
map("v", "<A-e>", ":m '>+1<CR>gv=gv")
map("i", "<A-e>", "<Esc>:m .+1<CR>==gi")
map("n", "<A-u>", ":m .-2<CR>==")
map("v", "<A-u>", ":m '<-2<CR>gv=gv")
map("i", "<A-u>", "<Esc>:m .-2<CR>==gi")

-- Switch buffer with tab
map("n", "<tab>", "<cmd>bnext<cr>")
map("n", "<s-tab>", "<cmd>bprevious<cr>")

-- insert mode navigation
map("i", "<A-Up>", "<C-\\><C-N><C-w>k")
map("i", "<A-Down>", "<C-\\><C-N><C-w>j")
map("i", "<A-Left>", "<C-\\><C-N><C-w>h")
map("i", "<A-Right>", "<C-\\><C-N><C-w>l")

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- lazy
map("n", "<leader>pi", "<cmd>Lazy install<cr>", { desc = "Install" })
map("n", "<leader>ps", "<cmd>Lazy sync<cr>", { desc = "Sync" })
map("n", "<leader>pC", "<cmd>Lazy clear<cr>", { desc = "Status" })
map("n", "<leader>pc", "<cmd>Lazy clean<cr>", { desc = "Clean" })
map("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Update" })
map("n", "<leader>pp", "<cmd>Lazy profile<cr>", { desc = "Profile" })
map("n", "<leader>pl", "<cmd>Lazy log<cr>", { desc = "Log" })
map("n", "<leader>pd", "<cmd>Lazy debug<cr>", { desc = "Debug" })

-- Terminal window navigation
map("t", "<C-n>", "<C-\\><C-N><C-w>h", { desc = "move to left" })
map("t", "<C-e>", "<C-\\><C-N><C-w>j", { desc = "move to down" })
map("t", "<C-u>", "<C-\\><C-N><C-w>k", { desc = "move to up" })
map("t", "<C-i>", "<C-\\><C-N><C-w>l", { desc = "move to right" })
-- map tab to tab, because distinguish between <C-i>
map("t", "<Tab>", "<Tab>")

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
-- navigate tab completion with <c-e> and <c-j>
-- runs conditionally
map("c", "<C-e>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
map("c", "<C-u>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })

-- colemak goto new position in jumplist
-- map("n", "<C-h>", "<C-i>")

-- kill a line
map("i", "<C-k>", "<esc>ddi")

-- start / end of line
map("i", "<C-,>", "<esc>I")
map("i", "<C-.>", "<esc>A")

-- forword / backward word
map("i", "<C-f>", "<esc>ea")
map("i", "<C-b>", "<esc>bi")

-- Windows managenment
--Better window movement
map("n", "<C-w>", "<C-w>w", { desc = "Switch window" })
map("n", "<C-x>", "<C-w>x")
map("n", "<C-n>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-e>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-u>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-i>", "<C-w>l", { desc = "Go to right window" })
map("n", "<C-l>", "<C-w>o", { desc = "Clear other windwos" })
map("n", "<C-q>", "<C-w>q", { desc = "Quit window" })

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- disable the default s key
map({ "n", "x" }, "s", "<nop>", { desc = "split/surround/select" })

-- split the screens
map("n", "su", function()
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
map("n", "si", function()
  vim.opt.splitright = true
  vim.cmd([[vsplit]])
end, { desc = "split right" })

-- Rotate window
map("n", "<leader>wU", "<C-w>b<C-w>K", { desc = "rotate window up" })
map("n", "<leader>wN", "<C-w>b<C-w>H", { desc = "rotate window left" })

map("n", "<leader>ww", "<C-W>p", { desc = "other-window" })
map("n", "<leader>wd", "<C-W>c", { desc = "delete-window" })
-- move current windwo to the far left, bottom, right, top
map("n", "<leader>wn", "<C-w>H", { desc = "move to the far left" })
map("n", "<leader>we", "<C-w>J", { desc = "move to the far bottom" })
map("n", "<leader>wi", "<C-w>L", { desc = "move to the far right" })
map("n", "<leader>wu", "<C-w>K", { desc = "move to the far top" })

-- scroll
map({ "n", "v" }, "<C-k>", "<C-u>")
map({ "n", "v" }, "<C-m>", "<C-e>")

-- Tabs management
map("n", "<leader><tab>a", "<cmd>tabfirst<CR>", { desc = "First" })
map("n", "<leader><tab>z", "<cmd>tablast<CR>", { desc = "Last" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "]<tab>", "<cmd>tabn<CR>", { desc = "Next Tab" })
map("n", "[<tab>", "<cmd>tabp<CR>", { desc = "Prev Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<CR>", { desc = "Close" })
map("n", "<leader><tab>s", "<cmd>tab split<CR>", { desc = "Split" })
map("n", "<leader><tab>N", "<cmd>-tabmove<CR>", { desc = "Move to left" })
map("n", "<leader><tab>I", "<cmd>+tabmove<CR>", { desc = "Move to right" })
map("n", "<leader><tab>l", "<cmd>tabonly<CR>", { desc = "Close all other tabs" })
map("n", "<leader><tab>A", "<cmd>tabm 0<CR>", { desc = "Move to first" })
map("n", "<leader><tab>Z", "<cmd>tabm<CR>", { desc = "Move to last" })
map("n", "<leader><tab>t", "<cmd>tabs", { desc = "List all tabs" })

-- buffers
map("n", "]b", "<tab>", { remap = true, desc = "Next Buffer" })
map("n", "[b", "<S-tab>", { remap = true, desc = "Previous Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

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

-- files
-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- quickfix
map("n", "<leader>tl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>tq", "<cmd>copen<cr>", { desc = "Quickfix List" })

if not Util.has("trouble.nvim") then
  map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
  map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

-- Replace in selection
map("x", "s<cr>", ":s/\\%V", { desc = "replace in selection" })

-- toggle optional
map("n", "<leader>uf", require("saturn.plugins.lsp.format").toggle, { desc = "Toggle format on save" })
map("n", "<leader>us", function()
  Util.toggle("spell")
end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function()
  Util.toggle("wrap")
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function()
  Util.toggle("relativenumber", true)
  Util.toggle("number")
end, { desc = "Toggle Line Numbers" })

map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function()
  Util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end
