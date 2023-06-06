local autocmd = require("util").autocmd
local load = function(autocmds)
	for _, entry in ipairs(autocmds) do
		local event = entry[1]
		local opts = entry[2]
		autocmd.create_autocmds(event, opts)
	end
end

autocmd.clear_augroup("last_loc")
--- Load the default set of autogroups and autocommands.
local definitions = {
	{
		"FileType",
		{
			group = "_hide_dap_repl",
			pattern = "dap-repl",
			command = "set nobuflisted",
		},
	},
	{
		"FileType",
		{
			group = "_filetype_settings",
			pattern = { "lua" },
			desc = "fix gf functionality inside .lua files",
			callback = function()
				---@diagnostic disable: assign-type-mismatch
				-- credit: https://github.com/sam4llis/nvim-lua-gf
				vim.opt_local.include = [[\v<((do|load)file|require|reload)[^''"]*[''"]\zs[^''"]+]]
				vim.opt_local.includeexpr = "substitute(v:fname,'\\.','/','g')"
				vim.opt_local.suffixesadd:prepend(".lua")
				vim.opt_local.suffixesadd:prepend("init.lua")

				for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
					vim.opt_local.path:append(path .. "/lua")
				end
			end,
		},
	},
	{
		"FileType",
		{
			group = "close_with_q",
			pattern = {
				"floaterm",
				"lir",
				"lsp-installer",
				"null-ls-info",
				"DressingSelect",
				"Jaq",
				"dap-float",
				"httpResult",
			},
			callback = function()
				vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
				vim.opt_local.buflisted = false
			end,
		},
	},
	{
		"FileType",
		{
			group = "_filetype_settings",
			pattern = "qf",
			command = "set nobuflisted",
		},
	},
	{
		"FileType",
		{
			group = "_filetype_settings",
			pattern = "alpha",
			callback = function()
				vim.cmd([[
            nnoremap <silent> <buffer> q :qa<CR>
            nnoremap <silent> <buffer> <esc> :qa<CR>
            set nobuflisted
          ]])
			end,
		},
	},
	-- {
	-- 	"ColorScheme",
	-- 	{
	-- 		group = "_saturn_colorscheme",
	-- 		callback = function()
	-- 			require("saturn.plugins.ui.breadcrumbs").get_winbar()
	-- 			local statusline_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
	-- 			local cursorline_hl = vim.api.nvim_get_hl_by_name("CursorLine", true)
	-- 			local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
	-- 			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
	-- 			vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
	-- 			vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
	-- 			vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
	-- 			vim.api.nvim_set_hl(0, "CmpItemKindCodeium", { fg = "#7AA2F7" })
	-- 			vim.api.nvim_set_hl(0, "SLCopilot", { fg = "#6CC644", bg = statusline_hl.background })
	-- 			vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = cursorline_hl.background })
	-- 			vim.api.nvim_set_hl(0, "SLBranchName", { fg = normal_hl.foreground, bg = cursorline_hl.background })
	-- 			vim.api.nvim_set_hl(0, "SLSeparator", { fg = cursorline_hl.background, bg = statusline_hl.background })
	-- 		end,
	-- 	},
	-- },
	-- Enable spell checking for certain file types
	{
		{ "BufRead", "BufNewFile" },
		{
			group = "wrap_spell",
			pattern = { "*.txt", "*.tex" },
			callback = function()
				vim.opt_local.wrap = true
				vim.opt_local.spell = true
			end,
		},
	},
	{
		{ "BufEnter", "FileType" },
		{
			desc = "don't auto comment new line",
			pattern = "*",
			group = "_comment",
			command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
		},
	},
	{
		"BufWinLeave",
		{
			group = "rememberCursorAndFolds",
			pattern = "?*",
			callback = function()
				autocmd.remember("save")
			end,
		},
	},
	{
		"BufWinEnter",
		{
			group = "rememberCursorAndFolds",
			pattern = "?*",
			callback = function()
				autocmd.remember("load")
			end,
		},
	},
}
load(definitions)
