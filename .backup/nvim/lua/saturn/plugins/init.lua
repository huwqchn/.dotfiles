return {
  {
    "folke/lazy.nvim",
    tag = "stable",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
      { "tamago324/nlsp-settings.nvim" },
      {
        "Maan2003/lsp_lines.nvim",
        config = true,
        enabled = saturn.enable_extra_plugins and not saturn.lsp.diagnostics.virtual_text,
      },
      {
        "smjonas/inc-rename.nvim",
        cmd = "IncRename",
        config = saturn.enable_extra_plugins,
      },
    },
  },
  { "jose-elias-alvarez/null-ls.nvim" },
  {
    "williamboman/mason.nvim",
    init = function()
      require("saturn.plugins.mason").init()
    end,
    config = function()
      require("saturn.plugins.mason").config()
    end,
  },
  { "folke/tokyonight.nvim", lazy = false, priority = 999 },
  { "lunarvim/lunar.nvim" },
  { "Tastyep/structlog.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      require("saturn.plugins.telescope").config()
    end,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        bulid = "make",
      },
      {
        "LukasPietzschmann/telescope-tabs",
        enabled = saturn.enable_extra_plugins,
      },
      {
        "nvim-telescope/telescope-media-files.nvim",
        enabled = saturn.enable_extra_plugins,
      },
    },
    cmd = "Telescope",
    enabled = saturn.plugins.telescope.active,
  },
  -- cmp
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require("saturn.plugins.cmp").config()
    end,
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
        enabled = saturn.enable_extra_plugins,
      },
      {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        init = function()
          saturn.plugins.tabnine = {
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
          }
        end,
        config = function()
          require("cmp_tabnine.config").setup(saturn.plugins.tabnine)
        end,
        enabled = saturn.enable_extra_plugins,
      },
    },
    enabled = saturn.plugins.cmp.active,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local utils = require("saturn.utils.helper")
      local paths = {}
      if saturn.plugins.luasnip.sources.friendly_snippets then
        paths[#paths + 1] = utils.join_paths(vim.call("stdpath", "data"), "lazy", "friendly-snippets")
      end
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
        cond = saturn.plugins.luasnip.sources.friendly_snippets,
      },
    },
  },
  { "folke/neodev.nvim" },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("saturn.plugins.autopairs").config()
    end,
    enabled = saturn.plugins.autopairs.active,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      require("saturn.plugins.treesitter").config()
    end,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      {
        "p00f/nvim-ts-rainbow",
        enabled = saturn.enable_extra_plugins and saturn.plugins.treesitter.rainbow.enable,
      },
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "VeryLazy",
  },

  -- NvimTree
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("saturn.plugins.nvim-tree").config()
    end,
    cmd = "NvimTreeToggle",
    enabled = saturn.plugins.nvimtree.active,
  },
  -- Lir
  {
    "christianchiarulli/lir.nvim",
    config = function()
      require("saturn.plugins.lir").config()
    end,
    enabled = saturn.plugins.lir.active,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("saturn.plugins.gitsigns").config()
    end,
    event = "BufRead",
    enabled = saturn.plugins.gitsigns.active,
  },

  -- WhichKey
  {
    "folke/which-key.nvim",
    config = function()
      require("saturn.plugins.whichkey").config()
    end,
    event = "VeryLazy",
    enabled = saturn.plugins.whichkey.active,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("saturn.plugins.comment").config()
    end,
    enabled = saturn.plugins.comment.active,
  },

  -- Project
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("saturn.plugins.project").config()
    end,
    enabled = saturn.plugins.project.active,
  },

  -- Icons
  {
    "kyazdani42/nvim-web-devicons",
    enabled = saturn.use_icons,
  },

  -- Status Line and Bufferline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("saturn.plugins.lualine").config()
    end,
    enabled = saturn.plugins.lualine.active,
    event = "VeryLazy",
  },

  -- breadcrumbs
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("saturn.plugins.breadcrumbs").config()
    end,
    enabled = saturn.plugins.breadcrumbs.active,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("saturn.plugins.bufferline").config()
    end,
    event = "BufRead",
    branch = "main",
    enabled = saturn.plugins.bufferline.active,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("saturn.plugins.dap").config()
    end,
    enabled = saturn.plugins.dap.active,
    dependencies = {
      -- Debugger user interface
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("saturn.plugins.dap").config_ui()
        end,
      },
    },
  },

  -- alpha
  {
    "goolord/alpha-nvim",
    config = function()
      require("saturn.plugins.alpha").config()
    end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    branch = "main",
    config = function()
      require("saturn.plugins.toggleterm").config()
    end,
    enabled = saturn.plugins.toggleterm.active,
  },

  -- SchemaStore
  { "b0o/schemastore.nvim" },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("saturn.plugins.illuminate").config()
    end,
    event = "VeryLazy",
    enabled = saturn.plugins.illuminate.active,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("saturn.plugins.indentline").config()
    end,
    enabled = saturn.plugins.indentlines.active,
  },
  {
    "lunarvim/onedarker.nvim",
    branch = "freeze",
    config = function()
      pcall(function()
        if saturn and saturn.colorscheme == "onedarker" then
          require("onedarker").config()
          saturn.plugins.lualine.options.theme = "onedarker"
        end
      end)
    end,
    enabled = saturn.colorscheme == "onedarker",
  },
  {
    "lunarvim/bigfile.nvim",
    config = function()
      pcall(function()
        require("bigfile").config(saturn.plugins.bigfile.config)
      end)
    end,
    enabled = saturn.plugins.bigfile.active,
  },

  -- EXTRA PLUGINS ADD
  require("saturn.plugins.copilot"),
  require("saturn.plugins.todo-comments"),
}
