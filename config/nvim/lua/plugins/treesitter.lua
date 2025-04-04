return {
  -- {
  --   "andymass/vim-matchup",
  --   event = "BufReadPost",
  --   init = function()
  --     vim.o.matchpairs = "(:),{:},[:],<:>"
  --   end,
  --   config = function()
  --     vim.g.matchup_matchparen_deferred = 1
  --     vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
  --     vim.g.matchup_matchpref = { html = { nolists = 1 } }
  --   end,
  -- },
  -- {
  --   "nvim-treesitter/playground",
  --   cmd = {
  --     "TSPlaygroundToggle",
  --     "TSNodeUnderCursor",
  --     "TSHighlightCapturesUnderCursor",
  --   },
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- matchup = {
      --   enable = true,
      -- },
      indent = { enable = true, disable = { "yaml", "python", "css", "c", "cpp" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "ss",
          node_incremental = "ss",
          node_decremental = "sS",
          scope_incremental = "so",
        },
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "l",
          toggle_hl_groups = "h",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "H",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    },
  },
}
