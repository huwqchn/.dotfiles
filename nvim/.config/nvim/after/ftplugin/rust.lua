require("saturn.plugins.lsp.manager").setup("rust_analyzer")
saturn.plugins.dap.on_config_done = require("saturn.utils.dap").codelldb_config

saturn.plugins.which_key.mappings["<leader>n"] = { name = "+rust" }
saturn.plugins.which_key.mappings["<leader>nc"] = { name = "+crates" }
