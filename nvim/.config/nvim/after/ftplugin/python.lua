-- set a formatter
require("saturn.plugins.lsp.null-ls.formatters").setup({ { command = "black", filetype = { "python" } } })

-- set a linter
require("saturn.plugins.lsp.null-ls.linters").setup({ { command = "flake8", filetypes = { "python" } } })

-- set lsp for python
require("saturn.plugins.lsp.manager").setup("pyright")

--Setup dap for python
-- local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
pcall(function()
  -- require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
  require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
end)

-- Supported test frameworks are unittest, pytest and django. By default it
-- tries to detect the runner by probing for pytest.ini and manage.py, if
-- neither are present it defaults to unittest.
pcall(function()
  require("dap-python").test_runner = "pytest"
end)

vim.keymap.set("n", "<leader>dt", "<cmd>lua require('dap-python').test_method()<cr>", { desc = "Test Method" })
vim.keymap.set("n", "<leader>dT", "<cmd>lua require('dap-python').test_class()<cr>", { desc = "Test Class" })
vim.keymap.set("v", "<leader>ds", "<cmd>lua require('dap-python').debug_selection()<cr>", { desc = "Debug Selection" })
