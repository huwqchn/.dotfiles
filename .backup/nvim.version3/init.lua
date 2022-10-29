local base_dir = vim.env.NVIM_BASE_DIR

require("saturn.bootstrap"):init(base_dir)

require("saturn.config"):load()

local plugins = require "saturn.plugins"

require("saturn.plugin-loader").load { plugins, saturn.plugins }

require("saturn.core.theme").setup()

local Log = require "saturn.core.log"
Log:debug "Starting SaturnVim"

local commands = require "saturn.core.commands"
commands.load(commands.defaults)

require("saturn.lsp").setup()
