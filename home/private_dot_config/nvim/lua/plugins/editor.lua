return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
        window = {
          mappings = {
            ["h"] = "none",
            ["l"] = "none",
            ["n"] = "close_node",
            ["o"] = "open",
            ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "O" } },
            ["Oc"] = { "order_by_created", nowait = false },
            ["Od"] = { "order_by_diagnostics", nowait = false },
            ["Og"] = { "order_by_git_status", nowait = false },
            ["Om"] = { "order_by_modified", nowait = false },
            ["On"] = { "order_by_name", nowait = false },
            ["Os"] = { "order_by_size", nowait = false },
            ["Ot"] = { "order_by_type", nowait = false },
            ["oc"] = "none",
            ["od"] = "none",
            ["og"] = "none",
            ["om"] = "none",
            ["on"] = "none",
            ["os"] = "none",
            ["ot"] = "none",
          },
        },
      },
      buffers = {
        window = {
          mappings = {
            ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "O" } },
            ["Oc"] = { "order_by_created", nowait = false },
            ["Od"] = { "order_by_diagnostics", nowait = false },
            ["Om"] = { "order_by_modified", nowait = false },
            ["On"] = { "order_by_name", nowait = false },
            ["Os"] = { "order_by_size", nowait = false },
            ["Ot"] = { "order_by_type", nowait = false },
            ["o"] = "none",
            ["oc"] = "none",
            ["od"] = "none",
            ["om"] = "none",
            ["on"] = "none",
            ["os"] = "none",
            ["ot"] = "none",
          },
        },
      },
      git_status = {
        window = {
          mappings = {
            ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "O" } },
            ["Oc"] = { "order_by_created", nowait = false },
            ["Od"] = { "order_by_diagnostics", nowait = false },
            ["Om"] = { "order_by_modified", nowait = false },
            ["On"] = { "order_by_name", nowait = false },
            ["Os"] = { "order_by_size", nowait = false },
            ["Ot"] = { "order_by_type", nowait = false },
            ["o"] = "none",
            ["oc"] = "none",
            ["od"] = "none",
            ["om"] = "none",
            ["on"] = "none",
            ["os"] = "none",
            ["ot"] = "none",
          },
        },
      },
      window = {
        -- width = 30,
        mappings = {
          -- ["<cr>"] = "open_with_window_picker",
          ["e"] = "none",
          ["E"] = "toggle_auto_expand_width",
          ["N"] = {
            "toggle_node",
            nowait = false,
          },
          ["I"] = "show_file_details",
          ["i"] = "none",
          -- ["w"] = "open",
        },
      },
    },
  },
  {
    "folke/flash.nvim",
    optional = true,
    event = function()
      return {}
    end,
    opts = {
      search = { enabled = false },
      labels = "arstgmneioqwfpbjluyxcdvzkh",
      modes = {
        treesitter_search = {
          label = {
            rainbow = { enabled = true },
          },
        },
      },
    },
    keys = function(_, keys)
      keys[#keys + 1] = { "s", mode = { "n", "x", "o" }, false }
      keys[#keys + 1] = { "S", mode = { "n", "x", "o" }, false }
      keys[#keys + 1] = {
        "<cr>",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      }
      keys[#keys + 1] = {
        "<S-cr>",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      }
      for _, key in ipairs({ "f", "F", "t", "T", ";", ":", "/", "?" }) do
        table.insert(keys, key)
      end
      table.insert(keys, {
        "g<cr>",
        function()
          local Flash = require("flash")
          Flash.jump({
            search = { mode = "search" },
            label = { after = false, before = { 0, 0 }, uppercase = false },
            pattern = [[\<\|\>]],
            action = function(match, state)
              state:hide()
              Flash.jump({
                search = { max_length = 0 },
                label = { distance = false },
                highlight = { matches = false },
                matcher = function(win)
                  return vim.tbl_filter(function(m)
                    return m.label == match.label and m.win == win
                  end, state.results)
                end,
              })
            end,
            labeler = function(matches, state)
              local labels = state:labels()
              for m, match in ipairs(matches) do
                match.label = labels[math.floor((m - 1) / #labels) + 1]
              end
            end,
          })
        end,
        mode = { "n", "o", "x" },
        desc = "2-char jump",
      })
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      preset = "helix",
      plugins = {
        marks = true,
        registers = true,
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = false,
          nav = false,
          z = true,
          g = true,
        },
      },
      triggers = {
        { "s", mode = { "n", "x" } },
      },
    },
  },
  {
    "folke/trouble.nvim",
    optional = true,
    opts = {
      focus = true,
      keys = {
        I = "inspect",
        e = "next",
        i = "",
      },
      modes = {
        cascade = {
          mode = "diagnostics", -- inherit from diagnostics mode
          focus = true,
          filter = function(items)
            local severity = vim.diagnostic.severity.HINT
            for _, item in ipairs(items) do
              severity = math.min(severity, item.severity)
            end
            return vim.tbl_filter(function(item)
              return item.severity == severity
            end, items)
          end,
        },
      },
    },
  },
  {
    "echasnovski/mini.align",
    opts = {},
    keys = {
      { "ga", mode = { "n", "v" } },
      { "gA", mode = { "n", "v" } },
    },
  },
  {
    "echasnovski/mini.operators",
    event = "BufRead",
    keys = {
      { "<M-t>", "sxhww.", desc = "transpose word after", remap = true, silent = true },
      { "<M-S-t>", "sxhwb.", desc = "transpose word before", remap = true, silent = true },
      { "<M-m>", "gmm", desc = "multiply line", remap = true, silent = true },
      { "<M-r>", "schw", desc = "replace word", remap = true, silent = true },
    },
    opts = {
      exchange = {
        prefix = "sx",
      },
      replace = {
        prefix = "sc",
      },
    },
  },
  {
    "echasnovski/mini.bracketed",
    event = "BufReadPost",
    opts = {
      file = { suffix = "" },
      window = { suffix = "" },
      quickfix = { suffix = "" },
      yank = { suffix = "" },
      treesitter = { suffix = "n" },
    },
  },
  {
    "Wansmer/treesj",
    keys = { { "E", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    "chrisgrieser/nvim-spider",
    event = "VeryLazy",
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" }, desc = "Spider-w" },
      { "j", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" }, desc = "Spider-e" },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" }, desc = "Spider-b" },
      { "gj", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" }, desc = "Spider-ge" },
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    build = "./kitty/install-kittens.bash",
    lazy = false,
    keys = {
      { "<leader>wr", "<Cmd>SmartResizeMode<CR>", mode = "n", desc = "Resize mode" },
      -- resizing splits
      {
        mode = { "n", "t" },
        "<C-Left>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "resize left",
      },
      {
        mode = { "n", "t" },
        "<C-Down>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "resize down",
      },
      {
        mode = { "n", "t" },
        "<C-Up>",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "resize up",
      },
      {
        mode = { "n", "t" },
        "<C-Right>",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "resize right",
      },
      -- moving between splits
      {
        mode = { "n", "t" },
        "<C-n>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "move cursor left",
      },
      {
        mode = { "n", "t" },
        "<C-e>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "move cursor down",
      },
      {
        mode = { "n", "t" },
        "<C-i>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "move cursor up",
      },
      {
        mode = { "n", "t" },
        "<C-o>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "move cursor right",
      },
      -- swapping buffers between windows
      {
        mode = { "n", "t" },
        "sN",
        function()
          require("smart-splits").swap_buf_left()
        end,
        desc = "swap buffer left",
      },
      {
        mode = { "n", "t" },
        "sE",
        function()
          require("smart-splits").swap_buf_down()
        end,
        desc = "swap buffer down",
      },
      {
        mode = { "n", "t" },
        "sI",
        function()
          require("smart-splits").swap_buf_up()
        end,
        desc = "swap buffer up",
      },
      {
        mode = { "n", "t" },
        "sO",
        function()
          require("smart-splits").swap_buf_right()
        end,
        desc = "swap buffer right",
      },
    },
    opts = {
      ignored_filetypes = {
        "nofile",
        "quickfix",
        "prompt",
        "qf",
      },
      ignored_buftypes = { "NvimTree", "neo-tree" },
      default_amount = 3,
      move_cursor_same_row = false,
      resize_mode = {
        quit_key = "<ESC>",
        resize_keys = { "n", "e", "i", "o" },
        silent = false,
        hooks = {
          on_enter = function()
            vim.notify("Entering resize mode")
          end,
          on_leave = function()
            vim.notify("Exiting resize mode, bye")
          end,
        },
      },
      ignored_events = {
        "BufEnter",
        "WinEnter",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "file history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "current file history" },
      { "<leader>go", "<cmd>DiffviewOpen<cr>", desc = "diffview open" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "diffview close" },
      { "<leader>gt", "<cmd>DiffviewToggleFiles<cr>", desc = "toggle files" },
      { "<leader>gh", "<cmd>'<,'>DiffviewFileHistory<cr>", desc = "file history", mode = "v" },
    },
    cmd = {
      "DiffviewFileHistory",
      "DiffviewFileHistory",
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFileHistory",
    },
    config = true,
  },
  -- git blame
  {
    "f-person/git-blame.nvim",
    event = "BufReadPre",
    opts = function()
      vim.g.gitblame_date_format = "%r"
    end,
    keys = {
      { "<leader>ug", "<CMD>GitBlameToggle<CR>", desc = "Toggle GitBlame" },
    },
  },

  -- git conflict
  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    opts = {},
  },

  -- git ignore
  -- {
  --   "wintermute-cell/gitignore.nvim",
  --   keys = {
  --     {
  --       "<leader>gi",
  --       function()
  --         require("gitignore").generate()
  --       end,
  --       desc = "gitignore",
  --     },
  --   },
  -- },
  {
    "lewis6991/gitsigns.nvim",
    optional = true,
    opts = function(_, opts)
      return {
        on_attach = function(buffer)
          opts.on_attach(buffer)
          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          local function unmap(mode, key)
            vim.keymap.del(mode, key, { buffer = buffer })
          end

          unmap({ "o", "x" }, "ih")
          map({ "o", "x" }, "hh", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end,
      }
    end,
  },
}
