-- This file is automatically loaded by plugins.config
vim.opt.colorcolumn = "81"
vim.opt.whichwrap:append("<,>,[,],h,l")
-- vim.opt.listchars = { tab = "| ", trail = "▫" } -- replace special symbols
vim.opt.listchars = {
  nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends = "»", -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = "«", -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab = "  ", -- '▷─' WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
  trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
  space = " ",
}
vim.opt.fileencoding = "utf-8" -- the encoding written to a file

-- gui options
if vim.g.neovide then
  vim.opt.guifont = "FiraCode Nerd Font:h11"
  vim.g.neovide_scale_factor = 0.3
  vim.opt.guicursor = {
    "n-sm:block",
    "i-ci-c-ve:ver25",
    "r-cr-o-v:hor10",
    "a:blinkwait200-blinkoff500-blinkon700",
  }
end

vim.opt.hidden = true -- Enable modified buffers in background
-- vim.opt.inccommand = "split" -- preview incremental substitute
vim.opt.joinspaces = false -- No double spaces with join after a dot
vim.opt.pumblend = 0 -- Popup menu transparency, set not zero will show some bugs
vim.opt.spelllang:append("cjk")
--NOTE: vim.opt.timeoutlen = 0 make some keymaps not working
-- vim.opt.timeoutlen = 0
vim.opt.mousemoveevent = true

-- fold options
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  diff = "∙", -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob = " ", -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold = "·", -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert = "│", -- window border when window splits vertically ─ ┴ ┬ ┤ ├ ┼
}
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldcolumn = "0"

vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"

-- vim.g.node_host_prog = "/Users/folke/.pnpm-global/5/node_modules/neovim/bin/cli.js"
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"
if vim.fn.has("win32") == 1 then
  LazyVim.terminal.setup("pwsh")
end
