return {
	{
		"echasnovski/mini.surround",
		enabled = false,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {
			keymaps = {
				insert = "<C-h>s",
				insert_line = "<C-h>S",
				normal = "s",
				normal_line = "S",
				normal_cur_line = "ss",
				visual = "s",
				visual_line = "gS",
				delete = "sd",
				change = "sc",
			},
		},
	},
	{
		"folke/which-key.nvim",
		opts = {
			defaults = {
				mode = { "n", "v" },
				["s"] = { name = "+surround/select/split" },
				["gz"] = nil,
			},
		},
	},
}
