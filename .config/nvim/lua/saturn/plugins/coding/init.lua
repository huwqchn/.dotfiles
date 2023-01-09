local cmp_utils = require("saturn.plugins.coding.cmp")
return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-emoji" },
      { "hrsh7th/cmp-nvim-lua" },
      { "dmitmel/cmp-cmdline-history" },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local cmp_max_width = 0
      conf = {
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        completion = {
          ---@usage The minimum length of a word to complete on.
          keyword_length = 1,
        },
        experimental = {
          ghost_text = false,
          native_menu = false,
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          max_width = cmp_max_width,
          kind_icons = saturn.icons.kind,
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
          },
          duplicates = {
            buffer = 1,
            path = 1,
            nvim_lsp = 0,
            luasnip = 1,
          },
          duplicates_default = 0,
          format = function(entry, vim_item)
            local max_width = cmp_max_width
            if max_width ~= 0 and #vim_item.abbr > max_width then
              vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. saturn.icons.ui.Ellipsis
            end
            if saturn.use_icons then
              vim_item.kind = saturn.icons.kind[vim_item.kind]

              -- TODO: not sure why I can't put this anywhere else
              vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
              if entry.source.name == "copilot" then
                vim_item.kind = saturn.icons.git.Octoface
                vim_item.kind_hl_group = "CmpItemKindCopilot"
              end

              vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
              if entry.source.name == "cmp_tabnine" then
                vim_item.kind = saturn.icons.misc.Robot
                vim_item.kind_hl_group = "CmpItemKindTabnine"
              end

              vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
              if entry.source.name == "crates" then
                vim_item.kind = saturn.icons.misc.Package
                vim_item.kind_hl_group = "CmpItemKindCrate"
              end

              if entry.source.name == "lab.quick_data" then
                vim_item.kind = saturn.icons.misc.CircuitBoard
                vim_item.kind_hl_group = "CmpItemKindConstant"
              end

              vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
              if entry.source.name == "emoji" then
                vim_item.kind = saturn.icons.misc.Smiley
                vim_item.kind_hl_group = "CmpItemKindEmoji"
              end
            end
            vim_item.menu = conf.formatting.source_names[entry.source.name]
            vim_item.dup = conf.formatting.duplicates[entry.source.name]
              or conf.formatting.duplicates_default
            return vim_item
          end,
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          {
            name = "copilot",
            -- keyword_length = 0,
            max_item_count = 3,
            trigger_characters = {
              {
                ".",
                ":",
                "(",
                "'",
                '"',
                "[",
                ",",
                "#",
                "*",
                "@",
                "|",
                "=",
                "-",
                "{",
                "/",
                "\\",
                "+",
                "?",
                " ",
                -- "\t",
                -- "\n",
              },
            },
            group_index = 2,
          },
          {
            name = "nvim_lsp",
            entry_filter = function(entry, ctx)
              local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
              if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                return false
              end
              if kind == "Text" then
                return false
              end
              return true
            end,
            group_index = 2,
          },

          { name = "path", group_index = 2 },
          { name = "luasnip", group_index = 2 },
          { name = "cmp_tabnine", group_index = 2 },
          { name = "nvim_lua", group_index = 2 },
          { name = "buffer", group_index = 2 },
          { name = "calc", group_index = 2 },
          { name = "emoji", group_index = 2 },
          { name = "treesitter", group_index = 2 },
          { name = "crates", group_index = 2 },
          { name = "tmux", group_index = 2 },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
          ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping({
            i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif cmp_utils.jumpable(1) then
              luasnip.jump(1)
            elseif cmp_utils.has_words_before() then
              -- cmp.complete()
              fallback()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-c>"] = cmp.mapping.complete(),
          ["<C-x>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              local is_insert_mode = function()
                return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
              end
              if is_insert_mode() then -- prevent overwriting brackets
                confirm_opts.behavior = cmp.ConfirmBehavior.Insert
              end
              if cmp.confirm(conf.confirm_opts) then
                return -- success, exit early
              end
            end
            fallback() -- if not exited early, always fallback
          end),
        }),
        -- sorting = {
        --   priority_weight = 2,
        --   comparators = {
        --     require("copilot-cmp.comparators").prioritize,
        --     require("copilot-cmp.comparators").score,
        --
        --     -- Below is the default comparitor list and order for nvim-cmp
        --     cmp.config.compare.offset,
        --     -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        --     cmp.config.compare.exact,
        --     cmp.config.compare.score,
        --     cmp.config.compare.recently_used,
        --     cmp.config.compare.locality,
        --     cmp.config.compare.kind,
        --     cmp.config.compare.sort_text,
        --     cmp.config.compare.length,
        --     cmp.config.compare.order,
        --   },
        -- },
        cmdline = {
          enable = true,
          options = {
            {
              type = ":",
              sources = {
                { name = "path" },
                { name = "cmdline" },
              },
            },
            {
              type = { "/", "?" },
              sources = {
                { name = "buffer" },
              },
            },
          },
        },
      }
      cmp.setup(conf)

      if conf.cmdline.enable then
        for _, option in ipairs(conf.cmdline.options) do
          cmp.setup.cmdline(option.type, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = option.sources,
          })
        end
      end
    end,
    enabled = cmp_utils.enabled,
  },
  {
    "phaazon/hop.nvim",
    event = 'VeryLazy',
    config = function()
      local hop = require("hop")
      hop.setup({ keys = "arstdhneoioqwfplukmcxzv" })
      local directions = require("hop.hint").HintDirection
      vim.keymap.set("", "j", ":HopPattern<cr>", { silent = true })
      vim.keymap.set("", "<leader>jj", ":HopChar2<cr>", { silent = true, desc = "Jump" })
      vim.keymap.set("", "f", function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set("", "F", function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set("", "t", function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, { remap = true })
      vim.keymap.set("", "T", function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, { remap = true })
    end,
  },
  {
    "abecodes/tabout.nvim",
    event = "InsertEnter",
    dependencies = {
      "nvim-treesitter",
    },
    config = {
      tabkey = "<tab>", -- key to trigger tabout, set to an empty string to disable
      backwards_tabkey = "<s-tab>", -- key to trigger backwards tabout, set to an empty string to disable
      act_as_tab = true, -- shift content if tab out is not possible
      act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
      default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
      default_shift_tab = "<C-d>", -- reverse shift default action,
      enable_backwards = false, -- well ...
      completion = true, -- if the tabkey is used in a completion pum
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
        { open = "<", close = ">" },
      },
      ignore_beginning = false, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
      exclude = { "markdown" }, -- tabout will ignore these filetypes
    },
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local utils = require("saturn.utils.helper")
      local paths = {}
      paths[#paths + 1] = utils.join_paths(vim.call("stdpath", "data"), "lazy", "friendly-snippets")
      local user_snippets = utils.join_paths(vim.call("stdpath", "config"), "snippets")
      if utils.is_directory(user_snippets) then
        paths[#paths + 1] = user_snippets
      end
      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = paths,
      })
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
    event = "InsertEnter",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
      },
    },
  },

  -- auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },

  -- surround
  {
    "echasnovski/mini.surround",
    keys = { "s" },
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
    config = function(_, opts)
      -- use gz mappings instead of s to prevent conflict with leap
      require("mini.surround").setup(opts)
    end,
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },
  {
    "echasnovski/mini.ai",
    keys = {
      { "a", mode = { "x", "o" } },
      { "k", mode = { "x", "o" } },
    },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- no need to load the plugin, since we only need its queries
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end,
      },
    },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            k = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      local ai = require("mini.ai")
      ai.setup(opts)
    end,
  },
  {

    "ThePrimeagen/refactoring.nvim",
    keys = {
      {
        "<leader>r",
        function()
          require("refactoring").select_refactor()
        end,
        mode = "v",
        noremap = true,
        silent = true,
        expr = false,
      },
    },
    config = true,
  },
}
