-- :help options
local options = {
  backup = false,              -- creaters a backup file
  clipboard = 'unnamedplus',   -- allows neovim to access the system clipboard
  number = true,               -- shwo line numbers on left sidebar
  relativenumber = true,       -- show line number on the current line and relative numbers on all other lines
  cursorline = true,           -- highlight the line currently under curor
  mouse = 'a',                 -- enables mouser for scrolling and resizing
  scrolloff = 8,               -- the number of screen lines to keep above and below the cursor
  sidescrolloff = 8,           -- the number of screen columns to keep the left and right of the cursor
  colorcolumn = 81,            -- highlight a column
  showmode = false,            -- no need to show vim current mode
  textwidth = 0,               -- set text width
  expandtab = false,           -- don't convert tabs to spaces
  shiftwidth = 2,              -- when shifting, indent using four spaces
  tabshop = 2,                 -- indent using two spaces
  softtabstop = 2,
  autoindent = true,           -- new lines inherit the indentation of previous lines
  list = true,                  -- show special symbols
  listchars={tab:'| ', trail:'▫'}, -- replace special symbols
  smarttab = true,              -- insert 'tabstop' number of spaces when the 'tab' key is pressed
  title = true,                 -- set the window's title, reflecting the file currently
  confirm = true,               -- displays the confirmation dialog asking if you want to save the file
  hidden = true,                -- hide files instead of closing them when switch current file in buffer
  ruler = true,                 -- always show cursor position
  showmatch = true,             -- show match symbol
  incsearch = true,             -- incremental search that shows partial matches
  hlsearch = true,              -- search highlighting
  showcmd = true,               -- show command line
  wildmenu = true,              -- display command line's tab complete options as a menu
  ttimeoutlen = 0,              -- set vim will wait for longer after each keystroke of the mapping before aborting it and carrying out the behaviour
  timeout = false,              -- disable timeout on the vim leader key
  viewoptions = {'cursor', 'folds', 'slash', 'unix'} -- remembering some status
  warp = true,                  -- enable line wrap
  linebreak = true,             -- line wrap will not break word
  breakindent = true,           -- line wrap will has some indent
  ignorecase = true,            -- ignore case when searching
  smartcase = true,             -- automatically switch search to case-sensitive when search query contains an uppercase letter
  ttyfast = true,               -- should make scrolling faster
  lazyredray = true,            -- redraw editor when changed
  visualbell = true,
  foldenable = true,            -- enable fold text
  foldmethod = 'indent',        -- fold text by indent
  foldlevel = 99,
  splitright = true,            -- put vsplite window on the right of current window
  splitbelow = true,            -- put hsplite window on the below of current window
  inccommand = 'split',         -- preview command effect
  completeopt = {'longest', 'noinsert', 'menuone', 'noselect', 'preview'},
  updatetime = 100,             -- auto write time
  virtualedit = 'block',
  background = 'dark',
  autochdir = true,             -- auto change current directory
  signcolumn = 'yes',           -- always show the sign column
  fileencoding = 'utf-8',
  pumheight = 10,               -- pop up menu height
}

vim.opt.shortmess:append('c')
vim.opt.formatoptions:remove('tc')

vim.cmd 'set indentexpr='
vim.cmd "let &t_ut =''"

for k, v in pairs(options) do
  vim.opt[k] = v
end
