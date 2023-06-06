return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-emoji" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "dmitmel/cmp-cmdline-history" },
		},
		opts = function(_, opts)
			local cmp = require("cmp")
			opts.window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			}
			cmp.mapping.preset["<C-Space>"] = nil -- disable C-space
			table.insert(cmp.mapping.preset, {
				["<C-e>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			})
			table.insert(cmp.mapping.preset, {
				["<C-i>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			})
			-- opts.experimental = vim.tbl_extend("force", opts.experimental or {}, {
			-- 	native_menu = false,
			-- })
			-- opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
			-- 	{ name = "emoji" },
			-- 	{ name = "nvim_lua" },
			-- 	{ name = "treesitter" },
			-- 	{
			-- 		name = "nvim_lsp",
			-- 		entry_filter = function(entry, ctx)
			-- 			local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
			-- 			if kind == "Snippet" and ctx.prev_context.filetype == "java" then
			-- 				return false
			-- 			end
			-- 			if kind == "Text" then
			-- 				return false
			-- 			end
			-- 			return true
			-- 		end,
			-- 	},
			-- }))
			-- TODO:enable cmdline
		end,
	},
}
