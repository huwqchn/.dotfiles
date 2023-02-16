-- init saturn
saturn = vim.deepcopy(require("saturn.config.settings"))

-- follow env theme
local theme = os.getenv("THEME")
if theme then
  saturn.colorscheme = theme
end

require("saturn.lazy")
