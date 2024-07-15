return {
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-emoji" },
      { "hrsh7th/cmp-nvim-lua" },
      { "dmitmel/cmp-cmdline-history" },
      { "hrsh7th/cmp-nvim-lsp" },
    },
    keys = {
      { "<Tab>", mode = { "i", "s" } },
      { "<S-Tab>", mode = { "i", "s" } },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local neotab_ok, neotab = pcall(require, "neotab")
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
      opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
          elseif neotab_ok then
            neotab.tabout()
          else
            return fallback()
          end
        end),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
          else
            return fallback()
          end
        end),
        ["<C-e>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-i>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-c>"] = cmp.mapping.abort(),
        -- ["<C-x>"] = cmp.mapping.complete(),
        -- ["<C-Space>"] = nil,
      })
      opts.experimental = vim.tbl_extend("force", opts.experimental or {}, {
        native_menu = false,
      })
      opts.completion = vim.tbl_extend("force", opts.completion or {}, {
        ---@usage The minimum length of a word to complete on.
        keyword_length = 1,
      })
      local icons = LazyVim.config.icons
      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        kind_icons = icons.kinds,
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
          otter = "(Otter)",
        },
        duplicates = {
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
          luasnip = 1,
        },
        duplicates_default = 0,
        format = function(entry, item)
          local widths = {
            abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
            menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
          }

          for key, width in pairs(widths) do
            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
              item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
            end
          end
          item.kind = opts.formatting.kind_icons[item.kind]

          if entry.source.name == "copilot" then
            item.kind = icons.kinds.Copilot
            item.kind_hl_group = "CmpItemKindCopilot"
          end

          if entry.source.name == "cmp_tabnine" then
            item.kind = icons.kinds.TabNine
            item.kind_hl_group = "CmpItemKindTabnine"
          end

          if entry.source.name == "crates" then
            item.kind = opts.icons.Package
            item.kind_hl_group = "CmpItemKindCrate"
          end

          if entry.source.name == "emoji" then
            item.kind = opts.icons.Smiley
            item.kind_hl_group = "CmpItemKindEmoji"
          end

          if entry.source.name == "codeium" then
            item.kind = icons.kinds.Codeium
            item.kind_hl_group = "CmpItemKindCodeium"
          end

          if entry.source.name == "otter" then
            item.kind = opts.icons.otter
            item.kind_hl_group = "CmpItemKindOtter"
          end

          item.menu = opts.formatting.source_names[entry.source.name]
          item.dup = opts.formatting.duplicates[entry.source.name] or opts.formatting.duplicates_default
          return item
        end,
      }
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "emoji" },
        { name = "nvim_lua" },
        { name = "treesitter" },
        { name = "tmux" },
      }))
    end,
  },
  {
    "folke/ts-comments.nvim",
    optional = true,
    opts = {
      lang = {
        lua = "-- %s",
      },
    },
  },
  {
    "echasnovski/mini.ai",
    optional = true,
    keys = {
      { "a", mode = { "x", "o" } },
      { "h", mode = { "x", "o" } },
    },
    opts = {
      n_lines = 500,
      custom_textobjects = {
        w = { "()()%f[%w]%w+()[ \t]*()" },
      },
      mappings = {
        inside = "h",
        inside_next = "hn",
        inside_last = "hl",
      },
    },
  },
  {
    "echasnovski/mini.pairs",
    optional = true,
    event = function()
      return { "InsertEnter" }
    end,
  },
}
