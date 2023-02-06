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
}
