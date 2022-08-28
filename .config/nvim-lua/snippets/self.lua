

-- As defining all of the snippet-constructors (s, c, t, ...) in every file is rather cumbersome,
-- luasnip will bring some globals into scope for executing these files.
-- defined by snip_env in setup
require("luasnip.loaders.from_lua").lazy_load()
local env = Snip_env

return {
  env.parse("mail", "huwqchn@gmail.com"),
  env.s("date", env.p(os.date, "%Y-%m-%d")),
  env.s("time", env.p(os.date, "%H:%M")),
}
