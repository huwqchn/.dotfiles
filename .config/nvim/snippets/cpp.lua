require("luasnip").filetype_extend("cpp", { "c" })
return {
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
  s(
    "add",
    fmt(
      [[
    int h[N], e[N], nxt[N], idx;
    {}
    void add(int a, int b){{
      e[idx] = b, nxt[idx] = h[a], h[a] = idx++;
    }}
    ]],
      {
        i(1),
      }
    )
  ),
  s(
    "ADD",
    fmt(
      [[
    int h[N], e[M], w[M], nxt[M], nxt[M], idx;
    {}
    void add(int a, int b, int c) {{
      e[idx] = b, w[idx] = c, nxt[idx] = h[a], h[a] = idx++;
    }}
    ]],
      {
        i(1),
      }
    )
  ),
  s(
    "dijkstra",
    fmt(
      [[
    int n, m;
    int g[N][N];
    int dist[N];
    bool st[N];

    int dijkstra() {{
      memset(dist, 0x3f, sizeof dist);
      dist[1] = 0;

      for (int i = 0; i < n - 1; i ++ ) {{
        int t = -1;
        for (int j = 1; j <= n; j ++ )
          if (!st[j] && (t == -1 || dist[t] > dist[j]))
            t = j;

        for (int j = 1; j <= n; j ++ )
          dist[j] = min(dist[j], dist[t] + g[t][j]);

        st[t] = true;
      }}

      if (dist[n] == 0x3f3f3f3f) return -1;
      return dist[n];
    }}
    {}

    ]],
      {
        i(1),
      }
    )
  ),
  s(
    "Dijkstra",
    fmt(
      [[
      typedef pair<int, int> PII;

      const int N = 1e6 + 10;

      int n, m;
      int h[N], w[N], e[N], ne[N], idx;
      int dist[N];
      bool st[N];

      void add(int a, int b, int c) {{
        e[idx] = b, w[idx] = c, ne[idx] = h[a], h[a] = idx ++ ;
      }}

      int dijkstra() {{
        memset(dist, 0x3f, sizeof dist);
        dist[1] = 0;
        priority_queue<PII, vector<PII>, greater<PII>> heap;
        heap.push({{0, 1}});

        while (heap.size()) {{
          auto t = heap.top();
          heap.pop();

          int ver = t.second, distance = t.first;

          if (st[ver]) continue;
          st[ver] = true;

          for (int i = h[ver]; i != -1; i = ne[i]) {{
            int j = e[i];
            if (dist[j] > dist[ver] + w[i]) {{
              dist[j] = dist[ver] + w[i];
              heap.push({{dist[j], j}});
            }}
          }}
        }}

        if (dist[n] == 0x3f3f3f3f) return -1;
        return dist[n];
      }}
      {}
      ]],
      {
        i(1),
      }
    )
  ),
  s(
    "spfa",
    fmt(
      [[
      const int N = {};

      int n, m;
      int h[N], w[N], e[N], ne[N], idx;
      int dist[N];
      bool st[N];

      void add(int a, int b, int c) {{
        e[idx] = b, w[idx] = c, ne[idx] = h[a], h[a] = idx ++ ;
      }}

      int spfa() {{
        memset(dist, 0x3f, sizeof dist);
        dist[1] = 0;

        queue<int> q;
        q.push(1);
        st[1] = true;

        while (q.size()) {{
          int t = q.front();
          q.pop();

          st[t] = false;

          for (int i = h[t]; i != -1; i = ne[i]) {{
            int j = e[i];
            if (dist[j] > dist[t] + w[i]) {{
              dist[j] = dist[t] + w[i];
              if (!st[j]) {{
                q.push(j);
                st[j] = true;
              }}
            }}
          }}
        }}
        return dist[n];
      }}
      {}
    ]],
      {
        i(1, "100010"),
        i(2),
      }
    )
  ),
}
