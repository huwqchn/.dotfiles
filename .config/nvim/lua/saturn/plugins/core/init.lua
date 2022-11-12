-- core plugins
local M = {}

function M.config()
  require('saturn.plugins.core.whichkey').config()
  require('saturn.plugins.core.theme').config()
  require('saturn.plugins.core.gitsigns').config()
  require('saturn.plugins.core.cmp').config()
  require('saturn.plugins.core.dap').config()
  require('saturn.plugins.core.toggleterm').config()
  require('saturn.plugins.core.telescope').config()
  require('saturn.plugins.core.treesitter').config()
  require('saturn.plugins.core.nvim-tree').config()
  require('saturn.plugins.core.lir').config()
  require('saturn.plugins.core.illuminate').config()
  require('saturn.plugins.core.indentline').config()
  require('saturn.plugins.core.breadcrumbs').config()
  require('saturn.plugins.core.project').config()
  require('saturn.plugins.core.bufferline').config()
  require('saturn.plugins.core.autopairs').config()
  require('saturn.plugins.core.comment').config()
  require('saturn.plugins.core.lualine').config()
  require('saturn.plugins.core.mason').config()
end

function M.setup()
  require 'saturn.plugins.core.impatient'
  require('saturn.plugins.core.theme').setup()
  require('saturn.plugins.core.whichkey').setup()
  require 'saturn.plugins.core.alpha'
  --TODO:make lsp greater
  require 'saturn.plugins.core.lsp'
end

function M.get()
  local plugins = require 'saturn.plugins.core.collection'
  return plugins
end

return M

