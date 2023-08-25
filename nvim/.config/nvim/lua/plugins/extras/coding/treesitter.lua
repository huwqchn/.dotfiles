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
  {
    "nvim-treesitter/playground",
    cmd = {
      "TSPlaygroundToggle",
      "TSNodeUnderCursor",
      "TSHighlightCapturesUnderCursor",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    enabled = true,
    opts = { mode = "cursor" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "windwp/nvim-ts-autotag", opts = {} },
    },
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   dependencies = {
  --     {
  --       "HiPhish/nvim-ts-rainbow2",
  --       config = function()
  --         local rainbow = require("ts-rainbow")
  --
  --         require("nvim-treesitter.configs").setup({
  --           rainbow = {
  --             enable = true,
  --             -- list of languages you want to disable the plugin for
  --             disable = {},
  --             -- Which query to use for finding delimiters
  --             query = {
  --               "rainbow-parens",
  --               html = "rainbow-tags",
  --               latex = "rainbow-blocks",
  --               tsx = "rainbow-tags",
  --               vue = "rainbow-tags",
  --             },
  --             -- Highlight the entire buffer all at once
  --             strategy = {
  --               -- Use global strategy by default
  --               rainbow.strategy["global"],
  --               -- Use local for HTML
  --               html = rainbow.strategy["local"],
  --               -- Pick the strategy for LaTeX dynamically based on the buffer size
  --               latex = function()
  --                 -- Disabled for very large files, global strategy for large files,
  --                 -- local strategy otherwise
  --                 if vim.fn.line("$") > 10000 then
  --                   return nil
  --                 elseif vim.fn.line("$") > 1000 then
  --                   return rainbow.strategy["global"]
  --                 end
  --                 return rainbow.strategy["local"]
  --               end,
  --             },
  --           },
  --         })
  --       end,
  --     },
  --   },
  -- },
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
          node_incremental = "s=",
          node_decremental = "s-",
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
