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
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup({
            formatters = {
              insert_text = require("copilot_cmp.format").remove_existing,
            },
          })
        end,
        dependencies = {
          "copilot.lua",
        },
      },
      {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        config = function()
          require("cmp_tabnine.config").setup({
            max_lines = 1000,
            max_num_results = 20,
            sort = true,
            run_on_every_keystroke = true,
            snippet_placeholder = "..",
            ignored_file_types = { -- default is not to ignore
              -- uncomment to ignore in lua:
              -- lua = true
            },
            show_prediction_strength = true,
          })
        end,
      },
    },
    config = function()
      cmp_utils.config()
    end,
    enabled = cmp_utils.enabled,
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    config = {
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "<M-r>",
          open = "<M-space>",
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 75,
        keymap = {
          accept = "<M-cr>",
          next = "<M-i>",
          prev = "<M-n>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      copilot_node_command = "node", -- Node version must be < 18
      cmp = {
        enabled = true,
        method = "getCompletionsCycling",
      },
      -- plugin_manager_path = vim.fn.stdpath "data" .. "/site/pack/packer",
      server_opts_overrides = {
        -- trace = "verbose",
        settings = {
          advanced = {
            -- listCount = 10, -- #completions for panel
            inlineSuggestCount = 3, -- #completions for getCompletions
          },
        },
      },
    }
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
        suffix_last = 'u', -- Suffix to search with "prev" method
        suffix_next = 'e', -- Suffix to search with "next" method
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
    event = "VeryLazy",
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>/",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        mode = "n",
        desc = "Comment",
      },
      {
        "<leader>/",
        "<Plug>(comment_toggle_linewise_visual)",
        mode = "v",
        desc = "Comment toggle linewise (visual)",
      },
    },
    config = function()
      local pre_hook
      local ts_comment = require("ts_context_commentstring.integrations.comment_nvim")
      pre_hook = ts_comment.create_pre_hook()

      require("Comment").setup({
        ---Add a space b/w comment and the line
        ---@type boolean
        padding = true,

        ---Whether cursor should stay at the
        ---same position. Only works in NORMAL
        ---mode mappings
        sticky = true,

        ---Lines to be ignored while comment/uncomment.
        ---Could be a regex string or a function that returns a regex string.
        ---Example: Use '^$' to ignore empty lines
        ---@type string|function
        ignore = "^$",

        ---Whether to create basic (operator-pending) and extra mappings for NORMAL/VISUAL mode
        ---@type table
        mappings = {
          ---operator-pending mapping
          ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
          basic = true,
          ---Extra mapping
          ---Includes `gco`, `gcO`, `gcA`
          extra = true,
        },

        ---LHS of line and block comment toggle mapping in NORMAL/VISUAL mode
        ---@type table
        toggler = {
          ---line-comment toggle
          line = "gcc",
          ---block-comment toggle
          block = "gbc",
        },

        ---LHS of line and block comment operator-mode mapping in NORMAL/VISUAL mode
        ---@type table
        opleader = {
          ---line-comment opfunc mapping
          line = "gc",
          ---block-comment opfunc mapping
          block = "gb",
        },

        ---LHS of extra mappings
        ---@type table
        extra = {
          ---Add comment on the line above
          above = "gcO",
          ---Add comment on the line below
          below = "gco",
          ---Add comment at the end of line
          eol = "gcA",
        },

        ---Pre-hook, called before commenting the line
        ---@type function|nil
        pre_hook = pre_hook,

        ---Post-hook, called after commenting is done
        ---@type function|nil
        post_hook = nil,
      })
    end,
  },

  -- better text-objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
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
        mappings = {
          -- Main textobject prefixes
          around = 'a',
          inside = 'k',

          -- Next/last variants
          around_next = 'an',
          inside_next = 'kn',
          around_last = 'al',
          inside_last = 'kl',

          -- Move cursor to corresponding edge of `a` textobject
          goto_left = 'g[',
          goto_right = 'g]',
        },
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
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
  -- {
  --   "echasnovski/mini.ai",
  --   keys = {
  --     { "a", mode = { "x", "o" } },
  --     { "k", mode = { "x", "o" } },
  --   },
  --   event = "VeryLazy",
  --   dependencies = {
  --     {
  --       "nvim-treesitter/nvim-treesitter-textobjects",
  --       init = function()
  --         -- no need to load the plugin, since we only need its queries
  --         require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
  --       end,
  --     },
  --   },
  --   opts = function()
  --     local ai = require("mini.ai")
  --     return {
  --       n_lines = 500,
  --       custom_textobjects = {
  --         o = ai.gen_spec.treesitter({
  --           a = { "@block.outer", "@conditional.outer", "@loop.outer" },
  --           k = { "@block.inner", "@conditional.inner", "@loop.inner" },
  --         }, {}),
  --         f = ai.gen_spec.treesitter({ a = "@function.outer", k = "@function.inner" }, {}),
  --         c = ai.gen_spec.treesitter({ a = "@class.outer", k = "@class.inner" }, {}),
  --       },
  --       mappings = {
  --         -- Main textobject prefixes
  --         around = 'a',
  --         inside = 'k',

  --         -- Next/last variants
  --         around_next = 'an',
  --         inside_next = 'kn',
  --         around_last = 'al',
  --         inside_last = 'kl',

  --         -- Move cursor to corresponding edge of `a` textobject
  --         goto_left = 'g[',
  --         goto_right = 'g]',
  --       },
  --     }
  --   end,
  --   config = function(_, opts)
  --     local ai = require("mini.ai")
  --     ai.setup(opts)
  --   end,
  -- },
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
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>c/",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Comment",
      },
    },
    config = { snippet_engine = "luasnip" },
    dependencies = { "nvim-treesitter" },
  },
  {
    "MattesGroeger/vim-bookmarks",
    config = true,
    keys = {
      { "<leader>ma", "<cmd>silent BookmarkAnnotate<cr>", desc = "Annotate" },
      { "<leader>mc", "<cmd>silent BookmarkClear<cr>", desc = "Clear" },
      { "<leader>mt", "<cmd>silent BookmarkToggle<cr>", desc = "Toggle" },
      { "<leader>me", "<cmd>silent BookmarkNext<cr>", desc = "Next" },
      { "<leader>mu", "<cmd>silent BookmarkPrev<cr>", desc = "Prev" },
      { "<leader>ml", "<cmd>silent BookmarkShowAll<cr>", desc = "Show All" },
      { "<leader>mx", "<cmd>BookmarkClearAll<cr>", desc = "Clear All" },
    },
    cmd = {
      "BookmarkToggle",
      "BookmarkAnnotate",
      "BookmarkNext",
      "BookmarkPrev",
      "BookmarkShowAll",
      "BookmarkClear",
      "BookmarkClearAll",
      "BookmarkMoveUp",
      "BookmarkMoveDown",
      "BookmarkMoveToLine",
      "BookmarkSave",
      "BookmarkLoad",
    },
  },
}
