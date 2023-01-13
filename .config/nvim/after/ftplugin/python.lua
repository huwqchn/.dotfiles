-- set a formatter
require("saturn.plugins.lsp.null-ls.formatters").setup{ {command = "black", filetype = { "python" } }, }

-- set a linter
require("saturn.plugins.lsp.null-ls.linters").setup{ { command = "flake8", filetypes = { "python" } }, }

-- set lsp for python
require("saturn.plugins.lsp.manager").setup("pyright")

--TODO:setup dap for python

