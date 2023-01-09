return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
      },
      {
        "p00f/nvim-ts-rainbow",
      },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      {
        "nvim-treesitter/nvim-treesitter-context",
      },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "cmake",
          "cpp",
          "css",
          "diff",
          "fish",
          "gitignore",
          "go",
          "graphql",
          "help",
          "html",
          "http",
          "java",
          "javascript",
          "jsdoc",
          "jsonc",
          "latex",
          "lua",
          "markdown",
          "markdown_inline",
          "meson",
          "ninja",
          "nix",
          "norg",
          "org",
          "php",
          "python",
          "query",
          "regex",
          "rust",
          "scss",
          "sql",
          "svelte",
          "teal",
          "toml",
          "tsx",
          "typescript",
          "vhs",
          "vim",
          "vue",
          "wgsl",
          "yaml",
          "json",
        }, -- put the language you want in this array
        -- ensure_installed = "all", -- one of "all" or a list of languages
        ignore_install = {}, -- List of parsers to ignore installing
        sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

        -- A directory to install the parsers into.
        -- By default parsers are installed to either the package dir, or the "site" dir.
        -- If a custom path is used (not nil) it must be added to the runtimepath.
        parser_install_dir = nil,
        -- Automatically install missing parsers when entering buffer
        auto_install = false,

        matchup = {
          enable = true, -- mandatory, false will disable the whole extension
          -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
        },
        highlight = {
          enable = true, -- false will disable the whole extension
          additional_vim_regex_highlighting = { "markdown" },
          disable = function(lang, buf)
            if vim.tbl_contains({ "latex" }, lang) then
              return true
            end

            local status_ok, big_file_detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
            return status_ok and big_file_detected
          end,
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
          config = {
            -- Languages that have a single comment style
            typescript = "// %s",
            css = "/* %s */",
            scss = "/* %s */",
            html = "<!-- %s -->",
            svelte = "<!-- %s -->",
            vue = "<!-- %s -->",
            json = "",
          },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },
        indent = { enable = true, disable = { "yaml", "python", "css", "c", "cpp" } },
        autotag = { enable = true },
        autopairs = { enable = true },
        textobjects = {
          swap = {
            enable = false,
            -- swap_next = textobj_swap_keymaps,
          },
          -- move = textobj_move_keymaps,
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["kf"] = "@function.inner",
              ["at"] = "@class.outer",
              ["kt"] = "@class.inner",
              ["ac"] = "@call.outer",
              ["kc"] = "@call.inner",
              ["aa"] = "@parameter.outer",
              ["ka"] = "@parameter.inner",
              ["al"] = "@loop.outer",
              ["kl"] = "@loop.inner",
              ["ak"] = "@conditional.outer",
              ["kk"] = "@conditional.inner",
              ["a/"] = "@comment.outer",
              ["k/"] = "@comment.inner",
              ["ab"] = "@block.outer",
              ["kb"] = "@block.inner",
              ["as"] = "@statement.outer",
              ["ks"] = "@scopename.inner",
              ["aA"] = "@attribute.outer",
              ["kA"] = "@attribute.inner",
              ["aF"] = "@frame.outer",
              ["kF"] = "@frame.inner",
            },
          },
        },
        textsubjects = {
          enable = false,
          keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
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
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
  },
  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },
}
