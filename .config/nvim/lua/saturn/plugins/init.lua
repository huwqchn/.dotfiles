local plugin_loader = require 'saturn.plugins.plugin_loader'
plugin_loader.init()

local core = require 'saturn.plugins.core'
core.config()

local extra = require 'saturn.plugins.extra'
extra.config()

plugin_loader.load( { core.get(), extra.get() } )

core.setup()
extra.setup()

require('saturn.plugins.extra.lsp').setup()
require('saturn.plugins.core.lsp').setup()
