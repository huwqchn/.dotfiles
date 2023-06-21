return {
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    init = function()
      vim.o.matchpairs = "(:),{:},[:],<:>"
    end,
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
      vim.g.matchup_matchpref = { html = { nolists = 1 } }
    end,
  },
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

  {
    "mfussenegger/nvim-treehopper",
    keys = { { "m", mode = { "o", "x" } } },
    config = function()
      vim.cmd([[
        omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
        xnoremap <silent> m :lua require('tsht').nodes()<CR>
      ]])
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    enabled = true,
    opts = { mode = "cursor" },
  },
  -- {
  --   "windwp/nvim-ts-autotag",
  --   event = "InsertEnter",
  --   opts = {
  --     filetypes = { "html", "xml" },
  --   },
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "windwp/nvim-ts-autotag", opts = {} },
    },
  },
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "p00f/nvim-ts-rainbow",
      },
    },
    opts = {
      rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
        colors = {
          "DodgerBlue",
          "Orchid",
          "Gold",
        },
        disable = { "html" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      matchup = {
        enable = true,
      },
      indent = { enable = true, disable = { "yaml", "python", "css", "c", "cpp" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "ss",
          node_incremental = "si",
          scope_incremental = "so",
          node_decremental = "se",
        },
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
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
