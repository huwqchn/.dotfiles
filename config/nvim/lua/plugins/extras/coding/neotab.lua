return {
  {
    "kawre/neotab.nvim",
    event = "InsertEnter",
    opts = {
      tabkey = "",
      act_as_tab = true,
      behavior = "nested",
      pairs = {
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "<", close = ">" },
      },
      exclude = {},
      smart_punctuators = {
        enabled = false,
        semicolon = {
          enabled = false,
          ft = { "cs", "c", "cpp", "java" },
        },
        escape = {
          enabled = true,
          triggers = {
            ["+"] = {
              pairs = {
                { open = '"', close = '"' },
              },
              space = { before = true, after = true },
              -- string.format(format, typed_char)
              format = " %s ", -- " + "
              ft = { "java" },
            },
            [","] = {
              pairs = {
                { open = "'", close = "'" },
                { open = '"', close = '"' },
              },
              format = "%s ", -- ", "
            },
            ["="] = {
              pairs = {
                { open = "(", close = ")" },
              },
              ft = { "javascript", "typescript" },
              format = " %s> ", -- ` => `
              -- string.match(text_between_pairs, cond)
              cond = "^$", -- match only pairs with empty content
            },
          },
        },
      },
    },
  },
}
