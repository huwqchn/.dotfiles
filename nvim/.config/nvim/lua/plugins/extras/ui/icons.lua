return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			icons = {
				Saturn = "",
				SeparatorRight = "",
				SeparatorLeft = "",
				GitBranch = "",
				GitLineAdded = "",
				GitLineModified = "",
				GitLineRemoved = "",
				LspPrefix = " ",
				DiagError = "",
				DiagWarning = "",
				DiagInformation = "",
				DiagHint = "",
				Keyboard = "",
				Bug = "",
			},
		},
	},
	{
		"SmiteshP/nvim-navic",
		opts = function(_, opts)
			opts.separator = " " .. ">" .. " "
		end,
	},
}
