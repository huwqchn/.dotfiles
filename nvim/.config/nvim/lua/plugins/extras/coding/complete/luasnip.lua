return {
  {
    "L3MON4D3/LuaSnip",
    event = "InsertCharPre",
    opts = {
      enable_autosnippets = true,
      updateevents = "TextChanged,TextChangedI",
    },
    keys = {
      {
        "<C-n>",
        mode = { "i", "s" },
      },
      {
        "<C-p>",
        mode = { "i", "s" },
      },
      {
        "<C-cr>",
        "<cmd>lua require'luasnip.extras.select_choice'()<cr>",
        mode = "i",
        desc = "select snippet choice",
      },
    },
    config = function(_, opts)
      local ls = require("luasnip")
      ls.config.set_config(opts)
      local user_snippets = vim.fn.stdpath("config") .. "/snippets"
      require("luasnip.loaders.from_lua").lazy_load({ paths = user_snippets })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = user_snippets })
      -- require("luasnip.loaders.from_snipmate").lazy_load()

      _G.s = ls.snippet
      _G.sn = ls.snippet_node
      _G.t = ls.text_node
      _G.i = ls.insert_node
      _G.f = ls.function_node
      _G.c = ls.choice_node
      _G.d = ls.dynamic_node
      _G.r = ls.restore_node
      _G.l = require("luasnip.extras").lambda
      _G.rep = require("luasnip.extras").rep
      _G.p = require("luasnip.extras").partial
      _G.m = require("luasnip.extras").match
      _G.n = require("luasnip.extras").nonempty
      _G.dl = require("luasnip.extras").dynamic_lambda
      _G.fmt = require("luasnip.extras.fmt").fmt
      _G.fmta = require("luasnip.extras.fmt").fmta
      _G.types = require("luasnip.util.types")
      _G.conds = require("luasnip.extras.conditions")
      _G.conds_expand = require("luasnip.extras.conditions.expand")
    end,
  },
}
