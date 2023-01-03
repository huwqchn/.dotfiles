require("saturn.basic"):init()

local log = require("saturn.plugins.log")
log:debug("Starting SaturnVim")

local plugin_loader = require("saturn.plugin_loader")
plugin_loader.init()

require("saturn.config")

local lsp_config = require("saturn.lsp")
lsp_config.config()

local plugins = require("saturn.plugins")
plugin_loader.load({ plugins })

lsp_config.setup()
require("saturn.plugins.theme").config()
require("saturn.plugins.lsp").setup()
