return {

	-- git blame
	{
		"f-person/git-blame.nvim",
		event = "BufReadPre",
	},

	-- git conflict
	{
		"akinsho/git-conflict.nvim",
		event = "BufReadPre",
		config = true,
	},
	-- git ignore
	{
		"wintermute-cell/gitignore.nvim",
		keys = {
			{
				"<leader>gi",
				function()
					require("gitignore").generate()
				end,
				desc = "gitignore",
			},
		},
	},
}
