local map = LazyVim.safe_keymap_set
-- local map = vim.keymap.set
-- local LazyVim = require("lazyvim.util")

-- Search visually selected text (slightly better than builtins in Neovim>=0.8)
map("x", "*", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]])
map("x", "#", [[y?\V<C-R>=escape(@", '?\')<CR><CR>]])

-- select all
map({ "n", "x", "i" }, "<C-a>", "<cmd>normal! ggVG<cr>")

-- new space line
-- map("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = "Put empty line above" })
-- map("n", "go", "<Cmd>call append(line('.'), repeat([''], v:count1))<CR>", { desc = "Put empty line below" })

-- paste
map("i", "<C-v>", "<C-g>u<Cmd>set paste<CR><C-r>+<Cmd>set nopaste<CR>")
map("t", "<C-v>", "<C-\\><C-N>pi")
map("c", "<C-v>", "<C-r>+")

-- inc/dec number
map({ "n", "v" }, "+", "<C-a>", { desc = "Increment number" })
map({ "n", "v" }, "-", "<C-x>", { desc = "Decrement number" })
map({ "n", "v" }, "g+", "g<C-a>", { desc = "Increment number" })
map({ "n", "v" }, "g-", "g<C-x>", { desc = "Decrement number" })

-- insert mode navigation
map("i", "<A-Up>", "<C-\\><C-N><C-w>k")
map("i", "<A-Down>", "<C-\\><C-N><C-w>j")
map("i", "<A-Left>", "<C-\\><C-N><C-w>h")
map("i", "<A-Right>", "<C-\\><C-N><C-w>l")

-- Terminal window navigation
--WARN: <esc><esc> is not work when timeoutlen=0
map("t", "<C-esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Down Window" })
map("t", "<C-e>", "<cmd>wincmd k<cr>", { desc = "Go to Up Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-q>", "<cmd>close<cr>", { desc = "Hide Terminal" })
-- map("n", "<C-cr>", function()
--   LazyVim.terminal(nil, { ft = "", border = "rounded" })
-- end, { desc = "Float Terminal" })
-- map("t", "<C-cr>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- btop
map("n", "<leader>xb", function()
  Snacks.terminal({ "btop" }, { esc_esc = false, ctrl_hjkl = false })
end, { desc = "btop" })

-- map tab to tab, because distinguish between <C-i>
map("t", "<Tab>", "<Tab>")

-- scroll window horizontally (scroll-horizontal)
-- < reference: https://unix.stackexchange.com/questions/110251/how-to-put-current-line-at-top-center-bottom-of-screen-in-vim
map("n", "[z", "zh", { desc = "scroll left", silent = true }) -- left
map("n", "]z", "zl", { desc = "scroll right", silent = true }) -- right

-- swap windows with sn se si so
map("n", "sH", "<C-w>H", { desc = "swap with left", remap = true })
map("n", "sJ", "<C-w>J", { desc = "swap with below", remap = true })
map("n", "sK", "<C-w>K", { desc = "swap with above", remap = true })
map("n", "sL", "<C-w>L", { desc = "swap with right", remap = true })

-- Resize with arrows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- other window keybindings
map("n", "<C-o>", "<C-w>o", { desc = "Clear other windows" })
-- map("n", "<C-x>", "<C-w>x", { desc = "Exchange window" })
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

-- map s to <nop>
vim.keymap.set("n", "s", "<nop>", { noremap = true, desc = "split/surround/selection" })
-- Resize with arrows
map("n", "s<Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "s<Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "s<Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "s<Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

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

-- Switch buffer with tab
-- vim.keymap.set("n", "<tab>", "<tab>") -- conflict with <C-i>
vim.keymap.set("n", "<tab>", "]b", { desc = "Next buffer", remap = true, silent = true })
vim.keymap.set("n", "<s-tab>", "[b", { desc = "Prev buffer", remap = true, silent = true })

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

map("n", "<leader><TAB>n", "<Cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader><TAB><TAB>", function()
  vim.ui.select(vim.api.nvim_list_tabpages(), {
    prompt = "Select Tab:",
    format_item = function(tabid)
      local wins = vim.api.nvim_tabpage_list_wins(tabid)
      local not_floating_win = function(winid)
        return vim.api.nvim_win_get_config(winid).relative == ""
      end
      wins = vim.tbl_filter(not_floating_win, wins)
      local bufs = {}
      for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = buf })
        if buftype ~= "nofile" then
          local fname = vim.api.nvim_buf_get_name(buf)
          table.insert(bufs, vim.fn.fnamemodify(fname, ":t"))
        end
      end
      local tabnr = vim.api.nvim_tabpage_get_number(tabid)
      local cwd = string.format(" %8s: ", vim.fn.fnamemodify(vim.fn.getcwd(-1, tabnr), ":t"))
      local is_current = vim.api.nvim_tabpage_get_number(0) == tabnr and "✸" or " "
      return tabnr .. is_current .. cwd .. table.concat(bufs, ", ")
    end,
  }, function(tabid)
    if tabid ~= nil then
      vim.cmd(tabid .. "tabnext")
    end
  end)
end, { desc = "Select tab" })

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

map("n", "<leader>bb", function()
  local curbufnr = vim.api.nvim_get_current_buf()
  local buflist = vim.api.nvim_list_bufs()
  for _, bufnr in ipairs(buflist) do
    if vim.bo[bufnr].buflisted and bufnr ~= curbufnr and (vim.fn.getbufvar(bufnr, "bufpersist") ~= 1) then
      vim.cmd("bd " .. tostring(bufnr))
    end
  end
end, { silent = true, desc = "Close unused buffers" })

vim.keymap.set("n", "<C-w>", "<leader>bd", { remap = true, desc = "Close Buffer" })

-- Replace in selection
map("x", "s/", ":s/\\%V", { silent = false, desc = "replace in selection" })
-- search in selection
map("x", "g/", ":/\\%V", { silent = false, desc = "search in selection" })

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
vim.keymap.set("n", "dd", smart_dd, { noremap = true, expr = true, desc = "Don't yank empty line" })

-- delete current line marks
-- [src: https://github.com/lkhphuc/dotfiles/blob/master/nvim/lua/config/keymaps.lua]
local function delete_marks()
  local cur_line = vim.fn.line(".")
  -- Delete buffer local mark
  for _, mark in ipairs(vim.fn.getmarklist("%")) do
    if mark.pos[2] == cur_line and mark.mark:match("[a-zA-Z]") then
      vim.api.nvim_buf_del_mark(0, string.sub(mark.mark, 2, #mark.mark))
      return
    end
  end
  -- Delete global marks
  local cur_buf = vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win())
  for _, mark in ipairs(vim.fn.getmarklist()) do
    if mark.pos[1] == cur_buf and mark.pos[2] == cur_line and mark.mark:match("[a-zA-Z]") then
      vim.api.nvim_buf_del_mark(0, string.sub(mark.mark, 2, #mark.mark))
      return
    end
  end
end
vim.keymap.set("n", "dm", delete_marks, { noremap = true, desc = "Delete mark on the current line" })
