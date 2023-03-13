require("luasnip").filetype_extend("cpp", { "c" })
local snippets = {
  s("class", {
    -- Choice: Switch between two different Nodes, first parameter is its position, second a list of nodes.
    c(1, {
      t("public "),
      t("private "),
    }),
    t("class "),
    i(2),
    t(" "),
    c(3, {
      t("{"),
      -- sn: Nested Snippet. Instead of a trigger, it has a position, just like insertNodes. !!! These don't expect a 0-node!!!!
      -- Inside Choices, Nodes don't need a position as the choice node is the one being jumped to.
      sn(nil, {
        t("extends "),
        -- restoreNode: stores and restores nodes.
        -- pass position, store-key and nodes.
        r(1, "other_class", i(1)),
        t(" {"),
      }),
      sn(nil, {
        t("implements "),
        -- no need to define the nodes for a given key a second time.
        r(1, "other_class"),
        t(" {"),
      }),
    }),
    t({ "", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
  s("std", {
    t("using namespace std;"),
    i(1),
  }),
  s(
    "Bfs",
    fmt(
      [[
    int hh = 0, tt = 1;
    q[0] = {}, st[{}] = true;
    while (hh != tt) {{
      int t = q[hh++];
      if (hh == N) hh = 0;
      st[t] = false;
      {}
    }}
    ]],
      {
        i(1),
        d(2, function(args)
          return sn(nil, { i(1, args[1][1]) })
        end, { 1 }),
        i(0),
      }
    )
  ),
  s(
    "bs",
    fmt(
      [[
    int bsearch(int l, int x) {{
      while (l < r) {{
        int mid = l + r >> 1;
        if ({}) r = mid;
        else l = mid + 1;
      }}
      return l;
    }}
    {}
    ]],
      {
        i(1, "a[mid] >= x"),
        i(2, ""),
      }
    )
  ),
  s(
    "Bs",
    fmt(
      [[
      int bsearch(int l, int r) {{
        while (l < r) {{
          int mid = l + r + 1 >> 1;
          if ({}) l = mid;
          else r = mid - 1;
      }}
      {}
      ]],
      {
        i(1, "a[mid] <= x"),
        i(2, ""),
      }
    )
  ),
}

local autosnippets = {
  s(
    "#all",
    fmt(
      [[
    #include <bits/stdc++.h>
    {}
    ]],
      {
        i(1),
      }
    )
  ),
  s(
    "#algo",
    fmt(
      [[
      #include <cstring>
      #include <iostream>
      #include <algorithm>

      using namespace std;
      int main() {{
        {}

        return 0;
      }}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    { trig = "cout.(%a+);", regTrig = true },
    { f(function(_, snip)
      return 'std::cout << "' .. snip.captures[1] .. '"' .. " << std::endl;"
    end) }
  ),
  s( -- for([%w_]+) JS For Loop snippet{{{
    { trig = "for([%w_]+)", regTrig = true, hidden = true },
    fmt(
      [[
      for (int {} = 0; {} < {}; {}++) {{
        {}
      }}
      {}
    ]],
      {
        d(1, function(_, snip)
          return sn(1, i(1, snip.captures[1]))
        end),
        rep(1),
        c(2, { i(1, "N"), sn(1, { i(1, "arr"), t(".size()") }) }),
        rep(1),
        i(3, "// TODO:"),
        i(4),
      }
    )
  ),
  -- s(
  --   "INF",
  --   fmt(
  --     [[
  --     int INF = {};
  --     {}
  --     ]],
  --     {
  --       c(1, { i(1, "0x3f3f3f3f"), i(1, "1e9") }),
  --       i(2),
  --     }
  --   )
  -- ),
}
return snippets, autosnippets
