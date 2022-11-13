local M = {}

-- Initialize
function M:init()
  saturn = vim.deepcopy(require('saturn.basic.settings'))
  require('saturn.basic.keymaps').load()
  require('saturn.basic.options').load()
  require('saturn.basic.autocmds').load()
  -- require 'saturn.basic.autocmds'
end

return M
