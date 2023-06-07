return {
	{
		"hrsh7th/nvim-cmp",
		event = "CmdlineEnter",
		opts = function(_, opts)
			opts.cmdline = {
				{
					type = ":",
					sources = {
						{ name = "path" },
						{ name = "cmdline" },
					},
				},
				{
					type = { "/", "?" },
					sources = {
						{ name = "buffer" },
					},
				},
			}
		end,
		config = function(_, opts)
			local cmp = require("cmp")
			cmp.setup(opts)
			for _, option in ipairs(opts.cmdline) do
				cmp.setup.cmdline(option.type, {
					mapping = cmp.mapping.preset.cmdline(),
					sources = option.sources,
				})
			end
		end,
	},
}
