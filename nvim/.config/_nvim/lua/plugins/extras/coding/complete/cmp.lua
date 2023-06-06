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
			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				["<C-e>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-i>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						local confirm_opts = {
							behavior = cmp.ConfirmBehavior.Replace,
							select = false,
						}
						local is_insert_mode = function()
							return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
						end
						if is_insert_mode() then -- prevent overwriting brackets
							confirm_opts.behavior = cmp.ConfirmBehavior.Insert
						end
						local entry = cmp.get_selected_entry()
						local is_copilot = entry and entry.source.name == "copilot"
						if is_copilot then
							confirm_opts.behavior = cmp.ConfirmBehavior.Replace
							confirm_opts.select = true
						end
						if cmp.confirm(confirm_opts) then
							return -- success, exit early
						end
					end
					fallback() -- if not exited early, always fallback
				end),
			})
			opts.experimental = vim.tbl_extend("force", opts.experimental or {}, {
				native_menu = false,
			})
			opts.completion = vim.tbl_extend("force", opts.completion or {}, {
				---@usage The minimum length of a word to complete on.
				keyword_length = 1,
			})
			opts.formatting = {
				fields = { "kind", "abbr", "menu" },
				max_width = 0,
				kind_icons = require("lazyvim.config").icons.kinds,
				source_names = {
					nvim_lsp = "(LSP)",
					emoji = "(Emoji)",
					path = "(Path)",
					calc = "(Calc)",
					cmp_tabnine = "(Tabnine)",
					vsnip = "(Snippet)",
					luasnip = "(Snippet)",
					buffer = "(Buffer)",
					tmux = "(TMUX)",
					copilot = "(Copilot)",
					treesitter = "(TreeSitter)",
					codeium = "(Codeium)",
				},
				duplicates = {
					buffer = 1,
					path = 1,
					nvim_lsp = 0,
					luasnip = 1,
				},
				duplicates_default = 0,
				format = function(entry, item)
					local max_width = opts.formatting.max_width
					if max_width ~= 0 and #item.abbr > max_width then
						item.abbr = string.sub(item.abbr, 1, max_width - 1) .. ""
					end
					item.kind = opts.formatting.kind_icons[item.kind]

					item.menu = opts.formatting.source_names[entry.source.name]
					item.dup = opts.formatting.duplicates[entry.source.name] or opts.formatting.duplicates_default
					return item
				end,
			}
			opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
				{ name = "emoji" },
				-- { name = "nvim_lua" },
				-- { name = "treesitter" },
				-- {
				-- 	name = "nvim_lsp",
				-- 	entry_filter = function(entry, ctx)
				-- 		local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
				-- 		if kind == "Snippet" and ctx.prev_context.filetype == "java" then
				-- 			return false
				-- 		end
				-- 		if kind == "Text" then
				-- 			return false
				-- 		end
				-- 		return true
				-- 	end,
				-- },
			}))
			-- TODO:enable cmdline
		end,
	},
}
