return {

  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  -- makes some plugins dot-repeatable like leap
  {
    "tpope/vim-repeat",
    -- event = "VeryLazy",
    keys = {
      ".",
    },
  },
  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/leap.nvim",
    keys = {
      {
        "<leader>jj",
        "<cmd>lua require('leap').leap { target_windows = { vim.fn.win_getid() } }<cr>",
        desc = "jump",
        mode = { "n", "x" },
      },
      {
        "<leader>jw",
        "<cmd>lua require('leap').leap { target_windows = vim.tbl_filter(function (win) return vim.api.nvim_win_get_config(win).focusable end,vim.api.nvim_tabpage_list_wins(0))}<cr>",
        desc = "jump to any window",
        mode = { "n", "x" },
      },
      { ";", "<Plug>(leap-forward-to)", desc = "leap forward to", mode = { "n", "x", "o" } },
      { ":", "<Plug>(leap-backward-to)", desc = "leap backward to", mode = { "n", "x", "o" } },
      { "x", "<Plug>(leap-forward-till)", desc = "leap forward till", mode = { "x", "o" } },
      { "X", "<Plug>(leap-backward-till)", desc = "leap backward till", mode = { "x", "o" } },
      { "gs", "<Plug>(leap-cross-window)", desc = "leap cross window", mode = { "n", "x", "o" } },
    },
    dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "o" } } },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      -- leap.add_default_mappings(true)
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
  -- Preview number Jump
  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    config = function()
      require("numb").setup({
        show_numbers = true, -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
        -- hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
        -- number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
        -- centered_peeking = true, -- Peeked line will be centered relative to window
      })
    end,
  },
  -- Join
  {
    "echasnovski/mini.splitjoin",
    opts = { mappings = { toggle = "E" } },
    keys = {
      { "E", desc = "Split/Join" },
    },
  },
  -- structural replace
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>R",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    config = function()
      require("zen_mode").setup({
        window = {
          backdrop = 1,
          height = 0.9,
          -- width = 0.5,
          width = 80,
          options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
            cursorline = true,
            cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          gitsigns = { enabled = false },
          tmux = { enabled = true },
          twilight = { enabled = true },
        },
        on_open = function()
          require("lsp-inlayhints").toggle()
          vim.g.cmp_active = false
          vim.cmd([[LspStop]])
          vim.opt.relativenumber = false
        end,
        on_close = function()
          require("lsp-inlayhints").toggle()
          vim.g.cmp_active = true
          vim.cmd([[LspStart]])
          vim.opt.relativenumber = true
        end,
      })
    end,
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight" },
    keys = {
      { "<leader>zt", "<cmd>Twilight<cr>", desc = "Twilight" },
    },
    config = true,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup({
        filetypes = { "*", "!lazy" },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = { "*", "!prompt", "!nofile" },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = false, -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = false, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "background", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = false, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          virtualtext = saturn.icons.misc.Palette,
        },
      })

      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = {
          "*.css",
        },
        callback = function()
          require("colorizer").attach_to_buffer(0, { mode = "background", css = true })
        end,
      })
    end,
  },
  -- move
  {
    "echasnovski/mini.move",
    version = false,
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.move"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.left, mode = "x" },
        { opts.mappings.right, mode = "x" },
        { opts.mappings.down, mode = "x" },
        { opts.mappings.up, mode = "x" },
        { opts.mappings.line_left },
        { opts.mappings.line_right },
        { opts.mappings.line_down },
        { opts.mappings.line_up },
      }
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<M-n>",
        right = "<M-o>",
        down = "<M-e>",
        up = "<M-i>",
        -- Move current line in Normal mode
        line_left = "<M-n>",
        line_right = "<M-o>",
        line_down = "<M-e>",
        line_up = "<M-i>",
      },
    },
    config = function(_, opts)
      require("mini.move").setup(opts)
    end,
  },

  -- harpoon
  {
    "christianchiarulli/harpoon",
    keys = {
      { "]m", '<cmd>lua require("harpoon.ui").nav_next()<cr>', desc = "Next Mark File" },
      { "[m", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', desc = "Prev Mark File" },
      { "<leader>fh", "<cmd>Telescope harpoon marks<cr>", desc = "Search Mark Files" },
      { "<leader>m;", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = "Harpoon UI" },
      { "<leader>mm", '<cmd>lua require("harpoon.mark").add_file()<cr>', desc = "Harpoon" },
    },
    config = true,
  },

  -- pick color
  {
    "ziontee113/color-picker.nvim",
    cmd = { "PickColor", "PickColorInsert" },
    config = function()
      require("color-picker").setup({
        ["icons"] = { "ﱢ", "" },
        ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
        ["keymap"] = { -- mapping example:
          ["E"] = "<Plug>ColorPickerSlider5Decrease",
          ["I"] = "<Plug>ColorPickerSlider5Increase",
        },
        ["background_highlight_group"] = "Normal", -- default
        ["border_highlight_group"] = "FloatBorder", -- default
        ["text_highlight_group"] = "Normal", --default
      })
      vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
    end,
  },

  -- session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
  {
    "wintermute-cell/gitignore.nvim",
    keys = {
      {
        "<leader>gi",
        function()
          require("gitignore").generate()
        end,
        desc = "gitignore",
      },
    },
  },
  {
    "ecthelionvi/NeoComposer.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    init = function()
      saturn.plugins.NeoComposer = {
        loaded = false,
      }
    end,
    keys = {
      { "Q", mode = { "n", "v" }, desc = "Plays queued macro" },
      { "yq", mode = { "n", "v" }, desc = "Yanks macro" },
      { "cq", mode = { "n", "v" }, desc = "Halts macro" },
      { "q", mode = { "n", "v" }, desc = "Starts recordong" },
      { "<m-q>", mode = { "n", "v" }, desc = "Toggles macro menu" },
      { "]Q", mode = "n", desc = "Cycles to next macro" },
      { "[Q", mode = "n", desc = "Cycles to previous macro" },
    },
    cmds = {
      "EditMacros",
      "ClearNeoComposer",
    },
    opts = function()
      saturn.plugins.NeoComposer.loaded = true
      return {
        -- notify = true,
        -- delay_timer = "150",
        -- status_bg = saturn.colors.black,
        -- preview_fg = "#ff9e64",
        keymaps = {
          play_macro = "Q",
          yank_macro = "yq",
          stop_macro = "cq",
          toggle_record = "q",
          cycle_next = "]Q",
          cycle_prev = "[Q",
          toggle_macro_menu = "<m-q>",
        },
      }
    end,
  },
  { import = "saturn.plugins.extra.smart-splits" },
  { import = "saturn.plugins.extra.firenvim" },
  -- { import = "saturn.plugins.extra.hologram" },
}
