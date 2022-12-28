local manager = require "saturn.plugins.core.lsp.manager"
manager.setup("zk", {
  on_init = require("saturn.plugins.core.lsp").common_on_init,
  capabilities = require("saturn.plugins.core.lsp").common_capabilities,
} )
