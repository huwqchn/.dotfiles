-- extra plugins
local M = {}

function M.config()
  require('saturn.plugins.extra.autocmds')
  require('saturn.plugins.extra.telescope')
  require('saturn.plugins.extra.treesitter')
  require('saturn.plugins.extra.lsp').config()
  require('saturn.plugins.extra.copilot').config()
  require('saturn.plugins.extra.tabnine').config()
  require('saturn.plugins.extra.symbols-outline').config()
  require('saturn.plugins.extra.spectre').config()
  require('saturn.plugins.extra.todo-comments').config()
  require('saturn.plugins.extra.cybu').config()
  require('saturn.plugins.extra.dial').config()
  require('saturn.plugins.extra.bqf').config()
  require('saturn.plugins.extra.jaq').config()
  require('saturn.plugins.extra.lab').config()
  require('saturn.plugins.extra.notify').config()
  require('saturn.plugins.extra.aerial').config()
  require('saturn.plugins.extra.dressing').config()
  require('saturn.plugins.extra.zen-mode').config()
  require('saturn.plugins.extra.true-zen').config()
  require('saturn.plugins.extra.colorizer').config()
  require('saturn.plugins.extra.neogit').config()
  require('saturn.plugins.extra.tabout').config()
  require('saturn.plugins.extra.trouble').config()
  require('saturn.plugins.extra.persistence').config()
  require('saturn.plugins.extra.smart-splits').config()
end

function M.setup()
  require('saturn.plugins.extra.auto-session')
  require('saturn.plugins.extra.bookmark')
  require('saturn.plugins.extra.browse')
  -- require('saturn.plugins.extra.crates')
  require('saturn.plugins.extra.dressing')
  require('saturn.plugins.extra.spectre')
  require('saturn.plugins.extra.dial')
  require('saturn.plugins.extra.numb')
  require('saturn.plugins.extra.git')
  require('saturn.plugins.extra.harpoon')
  require('saturn.plugins.extra.surround')
  require('saturn.plugins.extra.neuron')
  require('saturn.plugins.extra.matchup')
  require('saturn.plugins.extra.lastplace')
  require('saturn.plugins.extra.goto-preview')
  -- require('saturn.plugins.extra.hop')
  -- require('saturn.plugins.extra.tabout').setup()
end


function M.get()
  local plugins = require 'saturn.plugins.extra.collection'
  return plugins
end

return M
