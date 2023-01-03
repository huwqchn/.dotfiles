local M = {}

-- Initialize
function M:init()
  saturn = vim.deepcopy(require("saturn.basic.settings"))
  require("saturn.basic.keymaps").load()
  require("saturn.basic.options").load()
  require("saturn.basic.autocmds").load()

  local commands = require("saturn.basic.commands")
  commands.load(commands.default)
end

return M
