local core = require 'saturn.plugins.core'
core.config()

local extra = require 'saturn.plugins.extra'
extra.config()

require 'saturn.plugins.packer'

core.setup()
extra.setup()
