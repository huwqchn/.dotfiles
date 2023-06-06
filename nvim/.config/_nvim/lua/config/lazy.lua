local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
	spec = {
		-- import LazyVim plugins
		{ "LazyVim/LazyVim", import = "lazyvim.plugins", version = "^2.0" },
		-- lazyvim editor extension modules
		{ import = "lazyvim.plugins.extras.util.project" },
		-- lazyvim dap core extension modules
		{ import = "lazyvim.plugins.extras.dap.core" },
		{ import = "lazyvim.plugins.extras.dap.nlua" },
		-- lazyvim test core extension modules
		{ import = "lazyvim.plugins.extras.test.core" },
		{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },
		-- { import = "lazyvim.plugins.extras.vscode" },
		{ import = "plugins" },
	},
	defaults = { lazy = true, version = false },
	install = { colorscheme = { "tokyonight", "habamax" } },
	ui = { border = "rounded" },
	git = {
		timeout = 120,
	},
	checker = { enabled = true },
	diff = {
		cmd = "terminal_git",
	},
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
