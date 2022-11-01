local M = {}

-- Initialize
function M:init()
  require('saturn.core.keymaps'):load()
  require('saturn.core.options'):load()
end

return M
