local M = {}

-- Initialize
function M:init()
  saturn = vim.deepcopy(require('saturn.core.settings'))
  require('saturn.core.keymaps'):load()
  require('saturn.core.options'):load()
end

return M
