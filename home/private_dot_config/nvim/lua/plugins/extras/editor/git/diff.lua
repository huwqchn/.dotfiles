return {
	{
		"sindrets/diffview.nvim",
		keys = {
			{ "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "file history" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "current file history" },
			{ "<leader>go", "<cmd>DiffviewOpen<cr>", desc = "diffview open" },
			{ "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "diffview close" },
			{ "<leader>gt", "<cmd>DiffviewToggleFiles<cr>", desc = "toggle files" },
			{ "<leader>gh", "<cmd>'<,'>DiffviewFileHistory<cr>", desc = "file history", mode = "v" },
		},
		cmd = {
			"DiffviewFileHistory",
			"DiffviewFileHistory",
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFileHistory",
		},
		config = true,
	},
}
