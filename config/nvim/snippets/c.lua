local snippets = {}

local autosinppets = {
  s( -- [while] JS While Loop snippet{{{
    "while",
    fmt(
      [[
      while ({}) {{
        {}
      }}
      ]],
      {
        i(1, ""),
        i(2, "// TODO:"),
      }
    )
  ),
  s(
    "switch",
    fmt(
      [[
      switch ({}) {{
        case {}:
          {}
          break;
        default:
          {}
          break;
      }}
      ]],
      {
        i(1, ""),
        i(2, ""),
        i(3, "// TODO:"),
        i(4, "// TODO:"),
      }
    )
  ),
}

return snippets, autosinppets
