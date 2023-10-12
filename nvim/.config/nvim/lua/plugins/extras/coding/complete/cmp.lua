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
    opts = function(_, opts)
      local cmp = require("cmp")
      local ls = require("luasnip")
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
      opts.mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local confirm_opts = {
              behavior = cmp.ConfirmBehavior.Replace,
              select = false,
            }
            local is_insert_mode = function()
              return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
            end
            if is_insert_mode() then -- prevent overwriting brackets
              confirm_opts.behavior = cmp.ConfirmBehavior.Insert
            end
            local entry = cmp.get_selected_entry()
            local is_copilot = entry and entry.source.name == "copilot"
            if is_copilot then
              confirm_opts.behavior = cmp.ConfirmBehavior.Replace
              confirm_opts.select = true
            end
            if cmp.confirm(confirm_opts) then
              return -- success, exit early
            end
          end
          fallback() -- if not exited early, always fallback
        end, { "i", "s" }),
        ["<C-n>"] = cmp.mapping(function()
          if ls.choice_active() then
            ls.change_choice(1)
          elseif cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          end
          -- fallback()
        end, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(function()
          if ls.choice_active() then
            ls.change_choice(-1)
          elseif cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          end
          -- fallback()
        end, { "i", "s" }),
        ["<C-i>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-e>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-c>"] = cmp.mapping.abort(),
        ["<C-x>"] = cmp.mapping.complete(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      })
      opts.experimental = vim.tbl_extend("force", opts.experimental or {}, {
        native_menu = false,
      })
      opts.completion = vim.tbl_extend("force", opts.completion or {}, {
        ---@usage The minimum length of a word to complete on.
        keyword_length = 1,
      })
      opts.formatting = {
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
          local max_width = opts.formatting.max_width
          if max_width ~= 0 and #item.abbr > max_width then
            item.abbr = string.sub(item.abbr, 1, max_width - 1) .. ""
          end
          item.kind = opts.formatting.kind_icons[item.kind]

          if entry.source.name == "copilot" then
            item.kind = opts.icons.Copilot
            item.kind_hl_group = "CmpItemKindCopilot"
          end
          if entry.source.name == "cmp_tabnine" then
            item.kind = opts.icons.Robot
            item.kind_hl_group = "CmpItemKindTabnine"
          end

          if entry.source.name == "crates" then
            item.kind = opts.icons.Package
            item.kind_hl_group = "CmpItemKindCrate"
          end

          if entry.source.name == "lab.quick_data" then
            item.kind = opts.icons.CircuitBoard
            item.kind_hl_group = "CmpItemKindConstant"
          end

          if entry.source.name == "emoji" then
            item.kind = opts.icons.Smiley
            item.kind_hl_group = "CmpItemKindEmoji"
          end

          if entry.source.name == "codeium" then
            item.kind = opts.icons.Magic
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
}
