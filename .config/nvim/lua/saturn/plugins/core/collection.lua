return {
  {
    "folke/lazy.nvim",
    tag = "stable"
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = { "mason-lspconfig.nvim", "nlsp-settings.nvim" }
  },
  { "williamboman/mason-lspconfig.nvim", lazy = true },
  { "tamago324/nlsp-settings.nvim", lazy = true },
  { "jose-elias-alvarez/null-ls.nvim", lazy = true },
  {
    "williamboman/mason.nvim",
    config = function()
      require("saturn.plugins.core.mason").setup()
    end,
  },
  { "folke/tokyonight.nvim", lazy = false, priority = 999, },
  { "lunarvim/lunar.nvim", },
  { "Tastyep/structlog.nvim" },
  { "nvim-lua/plenary.nvim", },
  { "nvim-lua/popup.nvim", },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      require("saturn.plugins.core.telescope").config()
    end,
    dependencies = { "telescope-fzf-native.nvim" },
    lazy = true,
    cmd = "Telescope",
    enabled = saturn.plugins.telescope.active,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    bulid = "make",
    lazy = true,
    enabled = saturn.plugins.telescope.active
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      if saturn.plugins.cmp then
        require('saturn.plugins.core.cmp').setup()
      end
    end,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "cmp-nvim-lsp",
      "cmp_luasnip",
      "cmp-buffer",
      "cmp-path",
      "cmp-cmdline",
      "cmp-cmdline-history",
      "cmp-emoji",
      "cmp-nvim-lua",
      "cmp-tabnine",
      "copilot-cmp",
    },
  },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "saadparwaiz1/cmp_luasnip", lazy = true },
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local utils = require 'saturn.utils.helper'
      local paths = {}
      if saturn.plugins.luasnip.sources.friendly_snippets then
        paths[#paths + 1] = utils.join_paths(vim.call("stdpath", "data"), "site", "pack", "packer", "start", "friendly-snippets")
      end
      local user_snippets = utils.join_paths(vim.call("stdpath", "config"), "snippets")
      if utils.is_directory(user_snippets) then
        paths[#paths + 1] = user_snippets
      end
      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = paths,
      }
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
    event = "InsertEnter",
    dependencies = {
      "friendly-snippets",
    },
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
    cond = saturn.plugins.luasnip.sources.friendly_snippets,
  },
  { "folke/neodev.nvim", lazy = true },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("saturn.plugins.core.autopairs").setup()
    end,
    enabled = saturn.plugins.autopairs.active,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function ()
      require('saturn.plugins.core.treesitter').setup()
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
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
      require("saturn.plugins.core.nvim-tree").setup()
    end,
    enabled = saturn.plugins.nvimtree.active,
  },
  -- Lir
  {
    "christianchiarulli/lir.nvim",
    config = function ()
      require('saturn.plugins.core.lir').setup()
    end,
    enabled = saturn.plugins.lir.active,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("saturn.plugins.core.gitsigns").setup()
    end,
    event = "BufRead",
    enabled = saturn.plugins.gitsigns.active,
  },

  -- WhichKey
  {
    "folke/which-key.nvim",
    config = function()
      require("saturn.plugins.core.whichkey").setup()
    end,
    event = "VeryLazy",
    enabled = saturn.plugins.whichkey.active,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("saturn.plugins.core.comment").setup()
    end,
    enabled = saturn.plugins.comment.active,
  },

  -- Project
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("saturn.plugins.core.project").setup()
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
      require('saturn.plugins.core.lualine').setup()
    end,
    enabled = saturn.plugins.lualine.active,
    event = "VeryLazy",
  },

  -- breadcrumbs
  {
    "SmiteshP/nvim-navic",
    config = function()
      require('saturn.plugins.core.breadcrumbs').setup()
    end,
    enabled = saturn.plugins.breadcrumbs.active,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    config = function()
      require('saturn.plugins.core.bufferline').setup()
    end,
    branch = "main",
    enabled = saturn.plugins.bufferline.active,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("saturn.plugins.core.dap").setup()
    end,
    enabled = saturn.plugins.dap.active,
  },

  -- Debugger user interface
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("saturn.plugins.core.dap").setup_ui()
    end,
    enabled = saturn.plugins.dap.active,
  },

  -- alpha
  {
    "goolord/alpha-nvim",
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    branch = "main",
    config = function()
      require('saturn.plugins.core.toggleterm').setup()
    end,
    enabled = saturn.plugins.toggleterm.active,
  },

  -- SchemaStore
  { "b0o/schemastore.nvim", lazy = true, },
  {
    "RRethy/vim-illuminate",
    config = function()
      require('saturn.plugins.core.illuminate').setup()
    end,
    event = "VeryLazy",
    enabled = saturn.plugins.illuminate.active,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require('saturn.plugins.core.indentline').setup()
    end,
    enabled = saturn.plugins.indentlines.active,
  },

  -- impatient
  {
    "lewis6991/impatient.nvim",
  },
  {
    "lunarvim/onedarker.nvim",
    branch = "freeze",
    config = function()
      pcall(function()
        if saturn and saturn.colorscheme == "onedarker" then
          require("onedarker").setup()
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
}
