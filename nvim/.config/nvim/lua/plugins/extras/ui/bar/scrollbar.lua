return {
	{
		"petertriho/nvim-scrollbar",
		event = "CursorMoved",
		keys = {
			{
				"<leader>ub",
				function()
					require("scrollbar.utils").toggle()
				end,
				desc = "toggle scrollbar",
			},
		},
		config = function(_, opts)
			require("scrollbar").setup(opts)
			pcall(function()
				require("scrollbar.handlers.gitsigns").setup()
				-- require("scrollbar.handlers.search").setup({
				--   -- hlslens config overrides
				-- })
			end)
		end,
	},
}
