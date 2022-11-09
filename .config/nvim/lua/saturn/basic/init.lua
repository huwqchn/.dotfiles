local M = {}

-- Initialize
function M:init()
  saturn = vim.deepcopy(require('saturn.basic.settings'))
  require('saturn.basic.keymaps'):load()
  require('saturn.basic.options'):load()
  require 'saturn.basic.autocommands'
end

return M
