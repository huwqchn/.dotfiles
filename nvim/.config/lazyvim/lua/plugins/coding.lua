return {

  -- extend auto completion
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-emoji" },
      { "hrsh7th/cmp-nvim-lua" },
      { "dmitmel/cmp-cmdline-history" },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local cmp_window = require("cmp.config.window")
      cmp.mapping.preset["<C-Space>"] = nil -- disable C-space
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
      opts.windows = vim.tbl_extend("force", opts.windows or {}, {
        completion = cmp_window.bordered(),
        documentation = cmp_window.bordered(),
      })
      opts.completion = vim.tbl_extend("force", opts.completion or {}, {
        ---@usage The minimum length of a word to complete on.
        keyword_length = 1,
      })
      opts.experimental = vim.tbl_extend("force", opts.experimental or {}, {
        native_menu = false,
      })
      opts.formatting = vim.tbl_extend("force", opts.formatting or {}, {
        fields = { "kind", "abbr", "menu" },
        max_width = 0,
        kind_icons = require("lazyvim.config").icons.kinds,
        source_names = {
          nvim_lsp = "(LSP)",
          emoji = "(Emoji)",
          path = "(Path)",
          calc = "(Calc)",
          cmp_tabnine = "(Tabnine)",
          vsnip = "(Snippet)",
          luasnip = "(Snippet)",
          buffer = "(Buffer)",
          tmux = "(TMUX)",
          copilot = "(Copilot)",
          treesitter = "(TreeSitter)",
          codeium = "(Codeium)",
        },
        duplicates = {
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
          luasnip = 1,
        },
        duplicates_default = 0,
      })
      opts.formatting.format = function(entry, item)
        local max_width = opts.formatting.max_width
        if max_width ~= 0 and #item.abbr > max_width then
          item.abbr = string.sub(item.abbr, 1, max_width - 1) .. ""
        end
        item.kind = opts.formatting.kind_icons[item.kind]

        item.menu = opts.formatting.source_names[entry.source.name]
        item.dup = opts.formatting.duplicates[entry.source.name] or opts.formatting.duplicates_default
        return item
      end
    end,
  },

  -- scopes
  {
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    config = true,
  },

  -- tidy
  {
    "mcauley-penney/tidy.nvim",
    event = "VeryLazy",
    config = {
      filetype_exclude = { "markdown", "diff" },
    },
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "comment",
          "diff",
          "dockerfile",
          "dot",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",
          "graphql",
          "hcl",
          "http",
          "jq",
          "make",
          "mermaid",
          "sql",
        })
      end
    end,
  },
}
