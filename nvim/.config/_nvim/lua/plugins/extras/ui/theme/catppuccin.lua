return {
	-- catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			transparent_background = false,
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		optional = true,
		opts = function(_, opts)
			local colors = require("catppuccin.palettes.mocha")
			opts.colors = {
				grey = colors.surface0,
				dark_grey = colors.overlay0,
				black = colors.base,
				red = colors.red,
				pink = colors.pink,
				yellow = colors.yellow,
				blue = colors.blue,
				green = colors.green,
				sky = colors.sky,
				cyan = colors.sapphire,
				voilet = colors.lavender, -- #B4BEFE
				purple = colors.mauve,
				teal = colors.teal,
				white = colors.text,
			}
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		optional = true,
		opts = function()
			local colors = require("catppuccin.palettes.mocha")
			return {
				handle = {
					color = colors.overlay0,
				},
				marks = {
					Search = { color = colors.maroon },
					Error = { color = colors.red },
					Warn = { color = colors.yellow },
					Info = { color = colors.green },
					Hint = { color = colors.blue },
					Misc = { color = colors.lavender },
				},
			}
		end,
	},
}
