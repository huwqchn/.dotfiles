return {

	-- auto pairs
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},

	-- surround
	{
		"echasnovski/mini.surround",
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete surrounding" },
				{ opts.mappings.find, desc = "Find right surrounding" },
				{ opts.mappings.find_left, desc = "Find left surrounding" },
				{ opts.mappings.highlight, desc = "Highlight surrounding" },
				{ opts.mappings.replace, desc = "Replace surrounding" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "sa", -- Add surrounding in Normal and Visual modes
				delete = "sd", -- Delete surrounding
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				replace = "sr", -- Replace surrounding
				update_n_lines = "sl", -- Update `n_lines`
				suffix_last = "i", -- Suffix to search with "prev" method
				suffix_next = "e", -- Suffix to search with "next" method
			},
		},
	},

	-- Comment
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{
		"echasnovski/mini.comment",
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local plugin = require("lazy.core.config").spec.plugins["mini.comment"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.comment, mode = { "n", "x" } },
				{ opts.mappings.comment_line },
				{ opts.mappings.textobject },
				{ "<c-/>", opts.mappings.comment_line, remap = true },
				{ "<c-/>", opts.mappings.comment, mode = "x", remap = true },
			}
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				comment = "gc",
				comment_line = "gcc",
				textobject = "gc",
			},
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},

	-- better text-objects
	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "h", mode = { "x", "o" } },
		},
		dependencies = { "nvim-treesitter-textobjects" },
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
					w = { "()()%f[%w]%w+()[ \t]*()" },
				},
				mappings = {
					inside = "h",
					inside_next = "hn",
					inside_last = "hl",
				},
			}
		end,
	},
	{
		"chrisgrieser/nvim-spider",
		keys = {
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" }, desc = "Spider-w" },
			{ "j", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" }, desc = "Spider-e" },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" }, desc = "Spider-b" },
			{ "gj", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" }, desc = "Spider-ge" },
		},
	},
	-- Join
	{
		"echasnovski/mini.splitjoin",
		opts = { mappings = { toggle = "E" } },
		keys = {
			{ "E", desc = "Split/Join" },
		},
	},
	-- move
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
