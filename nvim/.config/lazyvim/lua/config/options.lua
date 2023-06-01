-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- This file is automatically loaded by plugins.config

-- vim.opt.backup = false
-- vim.opt.swapfile = false
-- vim.opt.cmdheight = 1 -- move space in the neovim command line for displaying messages
vim.opt.colorcolumn = "81"
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.listchars = { tab = "| ", trail = "▫" } -- replace special symbols
vim.opt.autowrite = true -- enable auto write
vim.opt.clipboard = "unnamedplus" -- sync with system clipboard
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.conceallevel = 3 -- Hide * markup for bold and italic
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.confirm = true -- confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.formatoptions = "jcroqlnt" -- tcqj

-- grep opitons
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"

-- gui options
vim.opt.guifont = "FiraCode Nerd Font:h11"
vim.opt.guicursor = {
  "n-sm:block",
  "i-ci-c-ve:ver25",
  "r-cr-o-v:hor10",
  "a:blinkwait200-blinkoff500-blinkon700",
}

vim.opt.hidden = true -- Enable modified buffers in background
vim.opt.ignorecase = true -- Ignore case
vim.opt.inccommand = "split" -- preview incremental substitute
vim.opt.joinspaces = false -- No double spaces with join after a dot
vim.opt.laststatus = 0
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.mouse = "a" -- enable mouse mode
vim.opt.number = true -- Print line number
vim.opt.shortmess:append({ W = true, I = true, c = true })
-- vim.opt.pumblend = 10 -- Popup blend #### this will rendered pum icon incorrectly on kitty
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.scrolloff = 8 -- Lines of context
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.showmode = false -- dont show mode since we have a statusline
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.spelllang = { "en", "cjk" }
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.timeoutlen = 0
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200 -- save swap file and trigger CursorHold
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.wrap = false -- Disable line wrap
vim.opt.mousemoveevent = true

-- fold options
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldcolumn = "0"

vim.opt.backup = true
vim.opt.cmdheight = 0
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"

if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
  vim.opt.shortmess:append({ C = true })
end

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0
