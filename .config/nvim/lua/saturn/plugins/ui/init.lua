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
        "<bs>",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    config = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
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
    config = {
      icons = {
        ERROR = saturn.icons.diagnostics.Error,
        WARN = saturn.icons.diagnostics.Warning,
        INFO = saturn.icons.diagnostics.Information,
        DEBUG = saturn.icons.ui.Bug,
        TRACE = saturn.icons.ui.Pencil,
      },
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local lualine = require("lualine")
      local style = require("saturn.plugins.ui.lualine.styles").get_style("saturn")
      lualine.setup(style)
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
    config = {
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
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup({
        -- symbol = "▏",
        symbol = saturn.icons.ui.LineLeft,
        options = { try_as_border = true },
      })
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    event = "BufAdd",
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
        highlights = conf.hightlights
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

}
