return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "cmake", "cpp", "c" })
			end
		end,
	},
	-- correctly setup mason lsp extensions
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "clangd" })
			end
		end,
	},
	-- correctly setup lspconfig
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				clangd = {

					cmd = {
						"clangd",
						"--background-index",
						"--pch-storage=memory",
						"--clang-tidy",
						"--all-scopes-completion",
						"--suggest-missing-includes",
						"--cross-file-rename",
						"--completion-style=detailed",
					},
					init_options = {
						clangdFileStatus = true,
						usePlaceholders = true,
						completeUnimported = true,
						semanticHighlighting = true,
					},
					filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
					log_level = 2,
					root_dir = require("lspconfig.util").root_pattern({
						".clangd",
						".clang-tidy",
						".clang-format",
						"compile_commands.json",
						"compile_flags.txt",
						"configure.ac",
						".git",
					}) or vim.loop.cwd(),
					single_file_support = true,
				},
			},
			setup = {
				clangd = function()
					require("util").on_lsp_lazy("cpp", function()
						require("lazyvim.util").on_attach(function(client, _)
                -- stylua: ignore
                if client.name == "clangd" then
                  vim.keymap.set(
                    "n",
                    "<F4>",
                    "<cmd>ClangdSwitchSourceHeader<cr>",
                    { desc = "switch between header and source" }
                  )
                end
						end)
					end)
				end,
			},
		},
	},
}
