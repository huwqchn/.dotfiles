return {
	-- tokyonight
	{
		"folke/tokyonight.nvim",
		opts = {
			on_highlights = function(hl, c)
				hl.IndentBlanklineContextChar = {
					fg = c.dark5,
				}
				hl.TSConstructor = {
					fg = c.blue1,
				}
				hl.TSTagDelimiter = {
					fg = c.dark5,
				}
				hl.IlluminatedWordRead = {
					bg = "#3b4261",
					underline = true,
				}
				hl.IlluminatedWordText = {
					bg = "#3b4261",
					underline = true,
					-- italic = true,
				}
				hl.IlluminatedWordWrite = {
					bg = "#3b4261",
					underline = true,
				}
			end,
			style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
			transparent = false, -- Enable this to disable setting the background color
			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
			styles = {
				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "dark", -- style for sidebars, see below
				floats = "dark", -- style for floating windows
			},
			-- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
			sidebars = {
				"qf",
				"vista_kind",
				"terminal",
				"packer",
				"spectre_panel",
				"NeogitStatus",
				"help",
			},
			day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
			hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
			dim_inactive = false, -- dims inactive windows
			lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
			use_background = true, -- can be light/dark/auto. When auto, background will be set to vim.o.background
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local colors = require("tokyonight.colors").setup()
			opts.colors = {
				grey = colors.bg_highlight,
				dark_grey = colors.fg_dark,
				black = colors.black,
				red = colors.red1,
				pink = colors.red,
				yellow = colors.yellow,
				blue = colors.blue,
				green = colors.green,
				sky = colors.blue1,
				cyan = colors.cyan,
				voilet = colors.magenta,
				purple = colors.purple,
				teal = colors.teal,
				white = colors.fg,
			}
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		optional = true,
		opts = function()
			local colors = require("tokyonight.colors").setup()
			return {
				handle = {
					color = colors.bg_highlight,
				},
				marks = {
					Search = { color = colors.orange },
					Error = { color = colors.error },
					Warn = { color = colors.warning },
					Info = { color = colors.info },
					Hint = { color = colors.hint },
					Misc = { color = colors.purple },
				},
			}
		end,
	},
}