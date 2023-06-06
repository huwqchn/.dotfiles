return {
	{
		"anuvyklack/windows.nvim",
		event = "WinNew",
		keys = {
			{ "<leader>wz", "<Cmd>WindowsMaximize<CR>", desc = "Zoom" },
			{ "<leader>wv", "<Cmd>WindowsMaximizeVertically<CR>", desc = "Maximize Vertically" },
			{ "<leader>wh", "<Cmd>WindowsMaximizeHorizontally<CR>", desc = "Maximize Horizontally" },
			{ "<leader>wb", "<Cmd>WindowsEqualize<CR>", desc = "Balance" },
		},
		dependencies = {
			{ "anuvyklack/middleclass" },
			{ "anuvyklack/animation.nvim", enabled = false },
		},
		config = function()
			vim.o.winwidth = 5
			vim.o.equalalways = false
			require("windows").setup({
				animation = { enable = false, duration = 150 },
			})
		end,
	},
}
