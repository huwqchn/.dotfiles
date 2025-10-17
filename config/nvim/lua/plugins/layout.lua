local layout = require("util.layout")

if layout.is_colemak() then
  return {
    { import = "plugins.extras.colemak" },
  }
end

return {}
