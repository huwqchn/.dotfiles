return {
	{
		"simrat39/symbols-outline.nvim",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		opts = {
			keymaps = {
				close = { "<Esc>", "q" },
				goto_location = "<Cr>",
				focus_location = "<space>",
				hover_symbol = "<C-h>",
				toggle_preview = "I",
				fold = "n",
				unfold = "o",
			},
		},
	},
}
