-- extra plugins
local M = {}

function M.config()
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
  -- require('saturn.plugins.extra.tabout').config()
end

function M.setup()
  require('saturn.plugins.extra.auto-session')
  require('saturn.plugins.extra.bookmark')
  require('saturn.plugins.extra.browse')
  -- require('saturn.plugins.extra.crates')
  require('saturn.plugins.extra.dressing')
  require('saturn.plugins.extra.spectre')
  require('saturn.plugins.extra.dial')
  -- require('saturn.plugins.extra.tabout').setup()
end


function M.get()
  local plugins = require 'saturn.plugins.extra.collection'
  return plugins
end

return M
