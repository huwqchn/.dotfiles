return {
  {
    "hrsh7th/nvim-cmp",
    version = false,
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
        opts = {
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
        },
      },
    },
    config = function()
      require("saturn.plugins.coding.cmp").config()
    end,
  },
  { "hrsh7th/cmp-nvim-lsp" },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    opts = {
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
    },
  },

  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")
      local types = require("luasnip.util.types")
      ls.config.set_config({
        history = true,
        enable_autosnippets = true,
        updateevents = "TextChanged,TextChangedI",
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "<- choiceNode", "Comment" } },
            },
          },
        },
      })

      local paths = {}
      paths[#paths + 1] = vim.fn.stdpath("data") .. "/lazy/friendly-snippets/"
      local user_snippets = vim.fn.stdpath("config") .. "/snippets"
      paths[#paths + 1] = user_snippets
      require("luasnip.loaders.from_lua").lazy_load({ paths = user_snippets })
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = paths,
      })
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
    event = "InsertCharPre",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
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
    keys = function(plugin, keys)
      -- Populate the keys based on the user's options
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sl", -- Update `n_lines`
        suffix_last = "u", -- Suffix to search with "prev" method
        suffix_next = "e", -- Suffix to search with "next" method
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },
  {
    "numToStr/Comment.nvim",
    -- event = "VeryLazy",
    keys = {
      { "gc", mode = { "n", "v", "x" } },
      { "gb", mode = { "n", "v", "x" } },
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
    keys = {
      { "[f", desc = "Prev function" },
      { "]f", desc = "Next function" },
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

      -- add treesitter jumping
      ---@param capture string
      ---@param start boolean
      ---@param down boolean
      local function jump(capture, start, down)
        local rhs = function()
          local parser = vim.treesitter.get_parser()
          if not parser then
            return vim.notify("No treesitter parser for the current buffer", vim.log.levels.ERROR)
          end

          local query = vim.treesitter.get_query(vim.bo.filetype, "textobjects")
          if not query then
            return vim.notify("No textobjects query for the current buffer", vim.log.levels.ERROR)
          end

          local cursor = vim.api.nvim_win_get_cursor(0)

          ---@type {[1]:number, [2]:number}[]
          local locs = {}
          for _, tree in ipairs(parser:trees()) do
            for capture_id, node, _ in query:iter_captures(tree:root(), 0) do
              if query.captures[capture_id] == capture then
                local range = { node:range() } ---@type number[]
                local row = (start and range[1] or range[3]) + 1
                local col = (start and range[2] or range[4]) + 1
                if down and row > cursor[1] or (not down) and row < cursor[1] then
                  table.insert(locs, { row, col })
                end
              end
            end
          end
          return pcall(vim.api.nvim_win_set_cursor, 0, down and locs[1] or locs[#locs])
        end

        local c = capture:sub(1, 1):lower()
        local lhs = (down and "]" or "[") .. (start and c or c:upper())
        local desc = (down and "Next " or "Prev ") .. (start and "start" or "end") .. " of " .. capture:gsub("%..*", "")
        vim.keymap.set("n", lhs, rhs, { desc = desc })
      end

      for _, capture in ipairs({ "function.outer", "class.outer" }) do
        for _, start in ipairs({ true, false }) do
          for _, down in ipairs({ true, false }) do
            jump(capture, start, down)
          end
        end
      end
      return {
        n_lines = 500,
        mappings = {
          -- Main textobject prefixes
          around = "a",
          inside = "i",

          -- Next/last variants
          around_next = "ae",
          inside_next = "ke",
          around_last = "au",
          inside_last = "ku",

          -- Move cursor to corresponding edge of `a` textobject
          goto_left = "g[",
          goto_right = "g]",
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
      --HACK: use k as inside
      vim.api.nvim_set_keymap(
        "x",
        "k",
        [[v:lua.require("mini.ai").expr_textobject('x', 'i')]],
        { desc = "Inside textobject", expr = true, noremap = false }
      )
      vim.api.nvim_set_keymap(
        "o",
        "k",
        [[v:lua.require("mini.ai").expr_textobject('o', 'i')]],
        { desc = "Inside textobject", expr = true, noremap = false }
      )
      vim.keymap.set("v", "i", "l")
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
      {
        "<leader>rb",
        function()
          require("refactoring").refactor("Extract Block")
        end,
        mode = "n",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>rB",
        function()
          require("refactoring").refactor("Extract Block To File")
        end,
        mode = "n",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>ri",
        function()
          require("refactoring").refactor("Inline Variable")
        end,
        mode = "n",
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
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Comment",
      },
    },
    opts = { snippet_engine = "luasnip" },
    dependencies = { "nvim-treesitter" },
  },

  -- better increase/descrease
  {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-=>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-->", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      })
    end,
  },

  -- better yank/paste
  {
    "kkharji/sqlite.lua",
    enabled = function()
      return not jit.os:find("Windows")
    end,
  },
  {
    "gbprod/yanky.nvim",
    enabled = true,
    event = "BufReadPost",
    config = function()
      -- vim.g.clipboard = {
      --   name = "xsel_override",
      --   copy = {
      --     ["+"] = "xsel --input --clipboard",
      --     ["*"] = "xsel --input --primary",
      --   },
      --   paste = {
      --     ["+"] = "xsel --output --clipboard",
      --     ["*"] = "xsel --output --primary",
      --   },
      --   cache_enabled = 1,
      -- }

      require("yanky").setup({
        highlight = {
          timer = 150,
        },
        ring = {
          storage = jit.os:find("Windows") and "shada" or "sqlite",
        },
      })

      vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

      vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

      vim.keymap.set("n", "<c-[>", "<Plug>(YankyCycleForward)")
      vim.keymap.set("n", "<c-]>", "<Plug>(YankyCycleBackward)")

      vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
      vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
      vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
      vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

      vim.keymap.set("n", "<leader>P", function()
        require("telescope").extensions.yank_history.yank_history({})
      end, { desc = "Paste from Yanky" })
    end,
  },
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   cmd = {
  --     "ChatGPT",
  --     "ChatGPTActAs",
  --     "ChatGPTEditWithInstructions",
  --   },
  --   opts = {
  --     keymaps = {
  --       close = { "<C-c>", "<Esc>" },
  --       yank_last = "<C-y>",
  --       scroll_up = "<C-u>",
  --       scroll_down = "<C-e>",
  --       toggle_settings = "<C-o>",
  --       new_session = "<C-n>",
  --       cycle_windows = "<Tab>",
  --     },
  --   },
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
  -- {
  --   "MattesGroeger/vim-bookmarks",
  --   config = true,
  --   keys = {
  --     { "<leader>ma", "<cmd>silent BookmarkAnnotate<cr>", desc = "Annotate" },
  --     { "<leader>mc", "<cmd>silent BookmarkClear<cr>", desc = "Clear" },
  --     { "<leader>mt", "<cmd>silent BookmarkToggle<cr>", desc = "Toggle" },
  --     { "<leader>me", "<cmd>silent BookmarkNext<cr>", desc = "Next" },
  --     { "<leader>mu", "<cmd>silent BookmarkPrev<cr>", desc = "Prev" },
  --     { "<leader>ml", "<cmd>silent BookmarkShowAll<cr>", desc = "Show All" },
  --     { "<leader>mx", "<cmd>BookmarkClearAll<cr>", desc = "Clear All" },
  --   },
  --   cmd = {
  --     "BookmarkToggle",
  --     "BookmarkAnnotate",
  --     "BookmarkNext",
  --     "BookmarkPrev",
  --     "BookmarkShowAll",
  --     "BookmarkClear",
  --     "BookmarkClearAll",
  --     "BookmarkMoveUp",
  --     "BookmarkMoveDown",
  --     "BookmarkMoveToLine",
  --     "BookmarkSave",
  --     "BookmarkLoad",
  --   },
  -- },
}
