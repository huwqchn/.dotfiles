require("saturn.plugins.lsp.manager").setup("omnisharp")
saturn.plugins.dap.on_config_done = require("saturn.utils.dap").netcoredbg_config
