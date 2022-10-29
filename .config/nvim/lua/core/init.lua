local M = {}

-- Initialize
function M:init()
  saturn = vim.deepcopy(require "core.settings")
  require('core.keymaps'):load()
  require('core.options'):load()
end

return M
