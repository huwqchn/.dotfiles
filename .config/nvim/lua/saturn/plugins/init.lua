
local mason = require('saturn.plugins.mason')
mason.config()

local breadcrumbs = require('saturn.plugins.breadcrumbs')
breadcrumbs.config()

local treesitter = require('saturn.plugins.treesitter')
treesitter.config()

require "saturn.plugins.packer"
require "saturn.plugins.impatient"
-- require "saturn.plugins.autocommands"
require "saturn.plugins.colorscheme"
require "saturn.plugins.cmp"
require "saturn.plugins.telescope"
require "saturn.plugins.gitsigns"
-- require "saturn.plugins.treesitter"
require "saturn.plugins.autopairs"
require "saturn.plugins.comment"
require "saturn.plugins.nvim-tree"
require "saturn.plugins.bufferline"
require "saturn.plugins.lualine"
require "saturn.plugins.toggleterm"
require "saturn.plugins.project"
require "saturn.plugins.illuminate"
require "saturn.plugins.indentline"
require "saturn.plugins.alpha"
require "saturn.plugins.lsp"
require "saturn.plugins.dap"
require "saturn.plugins.whichkey"
require "saturn.plugins.lir"


-- setup
mason.setup()

