-- set a formatter
require("saturn.plugins.lsp.null-ls.formatters").setup({ { command = "black", filetype = { "python" } } })

-- set a linter
-- require("saturn.plugins.lsp.null-ls.linters").setup({ { command = "flake8", filetypes = { "python" } } })

-- set lsp for python
require("saturn.plugins.lsp.manager").setup("pyright")

saturn.plugins.which_key.mappings["<leader>n"] = { name = "+python" }
vim.keymap.set("n", "<leader>nt", "<cmd>lua require('dap-python').test_method()<cr>", { desc = "Test Method" })
vim.keymap.set("n", "<leader>nT", "<cmd>lua require('dap-python').test_class()<cr>", { desc = "Test Class" })
vim.keymap.set("n", "<leader>nd", "<cmd>lua require('dap-python').debug_selection()<cr>", { desc = "Debug Selection" })
