local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Remove all trailing whitespace on save
local trim_white_space_grp = augroup("TrimWhiteSpaceGrp", {clear = true})

autocmd("BufWritePre", {
	command = [[:%s/\s\+$//e]],
	group = trim_white_space_grp,
})

local cursor_grp = augroup("CursorLine", { clear = true })
autocmd({ "InsertLeave", "WinEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt.cursorline = true
		vim.opt.cursorcolumn = true
	end,
	group = cursor_grp,
})

autocmd(
	{ "InsertEnter", "WinLeave" },
	{
		pattern = "*",
		callback = function()
			vim.opt.cursorline = false
			vim.opt.cursorcolumn = false
		end,
		group = cursor_grp
	}
)

-- Enable spell checking for certain file types
autocmd(
	{ "BufRead", "BufNewFile" },
	{ pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" }
)

-- go to last loc when opening a buffer
autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- Set FileType options
local file_opt_grp = augroup("FileOptGrp", { clear = true })
autocmd(
	"FileType",
	{
		pattern = { "c", "cpp", "rs", "html", "htmldjango", "lua",
		"javascript", "nsis"},
		callback = function()
			vim.opt.shiftwidth = 2
			vim.opt.tabstop = 2
			vim.opt.expandtab = true
			vim.opt.cindent = true
			vim.opt.cinoptions= { "t0", "g1", "h1", "N-s", "j1" }
		end,
		group = file_opt_grp
	}
)

autocmd(
	"FileType",
	{
		pattern = "make",
		callback = function()
			vim.opt.expandtab = true
			vim.opt.tabstop = 8
			vim.opt.shiftwidth = 2
		end,
	}
)

-- TODO: seeming not working
autocmd(
  "BufLeave",
  { command = [[:%s/  /\t/g"]] }
)
