require('saturn.basic'):init()

require('saturn.plugins.core.mason').bootstrap()
local log = require 'saturn.plugins.log'
log:debug "Starting SaturnVim"

require 'saturn.plugins'
