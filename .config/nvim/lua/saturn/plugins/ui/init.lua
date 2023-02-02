return {
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },
  {
    "kyazdani42/nvim-web-devicons",
    enabled = saturn.use_icons,
  },
  -- ui components
  { "MunifTanjim/nui.nvim" },

  -- better vim.notify
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    keys = {
      {
        "<leader><bs>",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    config = function()
      local notify = require("notify")
      notify.setup({
        -- Icons for the different levels
        icons = {
          ERROR = saturn.icons.diagnostics.Error,
          WARN = saturn.icons.diagnostics.Warning,
          INFO = saturn.icons.diagnostics.Information,
          DEBUG = saturn.icons.ui.Bug,
          TRACE = saturn.icons.ui.Pencil,
        },
      })
      local notify_filter = notify
      vim.notify = function(msg, ...)
        if msg:match("character_offset must be called") then
          return
        end
        if msg:match("method textDocument") then
          return
        end
        if
          msg:match(
            "warning: multiple different client offset_encodings detected for buffer, this is not supported yet"
          )
        then
          return
        end

        notify_filter(msg, ...)
      end
    end,
  },
  {
    "stevearc/dressing.nvim",
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("saturn.plugins.ui.lualine")
      -- local lualine = require("lualine")
      -- local style = require("saturn.plugins.ui.lualine.styles").get_style("saturn")
      -- lualine.setup(style)
    end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = require("saturn.config.ui.logo")
      dashboard.section.buttons.val = {
        dashboard.button("f", saturn.icons.ui.FindFile .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("e", saturn.icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button(
          "p",
          saturn.icons.ui.Project .. " Find project",
          ":lua require('telescope').extensions.projects.projects()<CR>"
        ),
        dashboard.button("r", saturn.icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", saturn.icons.ui.FindText .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", saturn.icons.ui.Gear .. " Configuration", ":e $MYVIMRC <CR>"),
        dashboard.button("q", saturn.icons.ui.Quit .. " Quit", ":qa<CR>"),
      }
      -- local function footer()
      --   return "Stay foolish, Stay hungry"
      -- end

      -- local fortune = require("alpha.fortune")
      -- dashboard.section.footer.val = fortune

      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"

      dashboard.opts.opts.noautocmd = true

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    opts = {
      enabled = true,
      buftype_exclude = { "terminal", "nofile" },
      filetype_exclude = {
        "help",
        "alpha",
        "startify",
        "dashboard",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "text",
        "lazy",
        "neo-tree",
      },
      char = saturn.icons.ui.LineLeft,
      show_trailing_blankline_indent = false,
      show_first_indent_level = true,
      use_treesitter = true,
      show_current_context = false,
    },
  },

  -- active indent guide and indent text objects
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "BufReadPre",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "NvimTree",
          "Trouble",
          "lazy",
          "mason",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup({
        mappings = {
          -- Textobjects
          object_scope = "ii", -- integrate with mini.ai
          object_scope_with_border = "ai",

          -- Motions (jump to respective border line; if not present - body line)
          goto_top = "[i",
          goto_bottom = "]i",
        },
        symbol = saturn.icons.ui.LineLeft,
        options = { try_as_border = true },
      })
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Jump" },
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous" },
      { "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Pick Close" },
      { "<leader>bn", "<cmd>BufferLineCloseLeft<cr>", desc = "Close all to the left" },
      { "<leader>bi", "<cmd>BufferLineCloseRight<cr>", desc = "Close all to the right" },
      { "<leader>bD", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort by directory" },
      { "<leader>bL", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort by language" },
    },
    config = function()
      local bufferline = require("bufferline")
      local conf = require("saturn.plugins.ui.bufferline").config
      bufferline.setup({
        options = conf.options,
        highlights = conf.hightlights,
      })
    end,
  },
  {
    "SmiteshP/nvim-navic",
    config = function()
      local navic = require("nvim-navic")
      local breadcrumbs = require("saturn.plugins.ui.breadcrumbs")
      breadcrumbs.create_winbar()
      local conf = breadcrumbs.config
      navic.setup(conf.options)
    end,
  },

  {
    "karb94/neoscroll.nvim",
    keys = {
      { "<C-k>", mode = { "n", "v" } },
      { "<C-d>", mode = { "n", "v" } },
      { "<C-b>", mode = { "n", "v" } },
      { "<C-f>", mode = { "n", "v" } },
      { "<C-y>", mode = { "n", "v" } },
      { "<C-m>", mode = { "n", "v" } },
      { "zt", mode = "n" },
      { "zz", mode = "n" },
      { "zb", mode = "n" },
    },
    config = function()
      require("neoscroll").setup({
        easing_function = "quadratic", -- Default easing function
        -- Set any other options as needed
      })

      local t = {}
      -- Syntax: t[keys] = {function, {function arguments}}
      -- Use the "sine" easing function
      t["<C-k>"] = { "scroll", { "-vim.wo.scroll", "true", "350", [['sine']] } }
      t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "350", [['sine']] } }
      -- Use the "circular" easing function
      t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "500", [['circular']] } }
      t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "500", [['circular']] } }
      -- Pass "nil" to disable the easing animation (constant scrolling speed)
      t["<C-y>"] = { "scroll", { "-0.10", "false", "100", nil } }
      t["<C-m>"] = { "scroll", { "0.10", "false", "100", nil } }
      -- When no easing function is provided the default easing function (in this case "quadratic") will be used
      t["zt"] = { "zt", { "300" } }
      t["zz"] = { "zz", { "300" } }
      t["zb"] = { "zb", { "300" } }

      require("neoscroll.config").set_mappings(t)
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    event = "CursorMoved",
    opts = function()
      local colors = require("tokyonight.colors").setup()
      return {
        handle = {
          color = colors.bg_highlight,
        },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
      }
    end,
    config = function(_, opts)
      require("scrollbar").setup(opts)
      pcall(function()
        require("scrollbar.handlers.gitsigns").setup()
        -- require("scrollbar.handlers.search").setup({
        --   -- hlslens config overrides
        -- })
      end)
    end,
  },
  -- {
  --   "kevinhwang91/nvim-hlslens",
  --   keys = {
  --     { "=", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
  --     { "-", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },
  --     { "*", [[*<Cmd>lua require('hlslens').start()<CR>]] },
  --     { "#", [[#<Cmd>lua require('hlslens').start()<CR>]] },
  --     { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]] },
  --     { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]] },
  --     { "/" },
  --     { "?" },
  --   },
  -- },

  -- noicer ui too lag and noise
  {
    "folke/noice.nvim",
    enabled = false,
    event = "VeryLazy",
    config = function()
      require("saturn.plugins.ui.noice")
    end,
    deactivate = function()
      require("noice").disable()
    end,
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>ul", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>uh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>ua", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward" },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward"},
    },
  },
  {
    enabled = true,
    "anuvyklack/windows.nvim",
    event = "WinNew",
    keys = {
      { "<leader>wz", "<Cmd>WindowsMaximize<CR>", desc = "Zoom" },
      { "<leader>wv", "<Cmd>WindowsMaximizeVertically<CR>", desc = "Maximize Vertically" },
      { "<leader>wh", "<Cmd>WindowsMaximizeHorizontally<CR>", desc = "Maximize Horizontally" },
      { "<leader>wb", "<Cmd>WindowsEqualize<CR>", desc = "Balance" },
    },
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim", enabled = false },
    },
    config = function()
      vim.o.winwidth = 5
      vim.o.equalalways = false
      require("windows").setup({
        animation = { enable = false, duration = 150 },
      })
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "v1.*",
    keys = {
      {
        "<leader>ww",
        function()
          local picker = require("window-picker")
          local picked_window_id = picker.pick_window({
            include_current_win = true,
          }) or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end,
        desc = "Pick a window",
      },
      {
        "<leader>ws",
        function()
          local picker = require("window-picker")
          local window = picker.pick_window({
            include_current_win = false,
          })
          local target_buffer = vim.fn.winbufnr(window)
          -- Set the target window to contain current buffer
          vim.api.nvim_win_set_buf(window, 0)
          -- Set current window to contain target buffer
          vim.api.nvim_win_set_buf(0, target_buffer)
        end,
        desc = "Swap a window",
      },
    },
    opts = {
      selection_chars = "ARSTNEIOFPLUDHKMCV",
    },
    config = function(_, opts)
      require("window-picker").setup(opts)
    end,
  },
}
