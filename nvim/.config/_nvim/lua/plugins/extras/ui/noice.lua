---whether nvim runs in a GUI
---@return boolean
local function isGui()
	return vim.g.neovide or vim.g.goneovim or vim.g.started_by_firenvim
end

return {
	{
		"folke/noice.nvim",
		cond = not isGui(),
		opts = {
			lsp = {
				progress = {
					enabled = false,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
				cmdline_output_to_split = false,
				lsp_doc_border = true,
			},
			commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			},
		},
	},
}
