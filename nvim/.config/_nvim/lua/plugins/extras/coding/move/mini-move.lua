return {
	{
		"echasnovski/mini.move",
		version = false,
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local plugin = require("lazy.core.config").spec.plugins["mini.move"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.left, mode = "x" },
				{ opts.mappings.right, mode = "x" },
				{ opts.mappings.down, mode = "x" },
				{ opts.mappings.up, mode = "x" },
				{ opts.mappings.line_left },
				{ opts.mappings.line_right },
				{ opts.mappings.line_down },
				{ opts.mappings.line_up },
			}
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				left = "<M-n>",
				right = "<M-o>",
				down = "<M-e>",
				up = "<M-i>",
				-- Move current line in Normal mode
				line_left = "<M-n>",
				line_right = "<M-o>",
				line_down = "<M-e>",
				line_up = "<M-i>",
			},
		},
	},
}
