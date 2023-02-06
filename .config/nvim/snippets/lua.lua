return {
  -- e.g. local bar = require("foo.bar")
  s(
    "require",
    fmt([[local {} = require("{}")]], {
      d(2, function(args)
        local modules = vim.split(args[1][1], "%.")
        return sn(nil, { i(1, modules[#modules]) })
      end, { 1 }),
      i(1),
    })
  ),
  s("CMD", {
    t({ "vim.cmd[[", " " }),
    i(1, ""),
    t({ "", "]]" }),
  }),
  s(
    "cmd",
    fmt("vim.cmd[[{}]]", {
      i(1, ""),
    })
  ),
  s(
    "func",
    fmt(
      [[
    local {} = function({})
      {}
    end
    ]],
      {
        i(1, "Var"),
        c(2, { t(""), i(1, "Args") }),
        i(3, "Body"),
      }
    )
  ),
}
