local snippets = {}
local autosnippets = {
  s(
    "meta",
    fmt(
      [[
      @document.meta
      title: {}
      authors: Johnson
      categories: [{}]
      version: {}
      @end
      {}
      ]],
      {
        i(1),
        i(2),
        i(3, "1.0"),
        i(4),
      }
    )
  ),
}
return snippets, autosnippets
