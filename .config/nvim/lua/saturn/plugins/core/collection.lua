return {
  {
    "wbthomason/packer.nvim",
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-lua/popup.nvim",
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("saturn.plugins.core.autopairs").setup()
    end,
    disable = not saturn.plugins.autopairs.active,
  },
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("saturn.plugins.core.comment").setup()
    end,
    disable = not saturn.plugins.comment.active,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufReadPost",
  },
  {
    "kyazdani42/nvim-web-devicons",
    disable = not saturn.use_icons,
  },
  {
    "akinsho/bufferline.nvim",
    config = function()
      require('saturn.plugins.core.bufferline').setup()
    end,
    branch = "main",
    event = "BufWinEnter",
    disable = not saturn.plugins.bufferline.active,
  },
  {
    "moll/vim-bbye",
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require('saturn.plugins.core.lualine').setup()
    end,
    disable = not saturn.plugins.lualine.active,
  },
  {
    "akinsho/toggleterm.nvim",
    event = "BufWinEnter",
    branch = "main",
    config = function()
      require('saturn.plugins.core.toggleterm').setup()
    end,
    disable = not saturn.plugins.toggleterm.active,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("saturn.plugins.core.project").setup()
    end,
    disable = not saturn.plugins.project.active,
  },
  {
    "lewis6991/impatient.nvim",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require('saturn.plugins.core.indentline').setup()
    end,
    disable = not saturn.plugins.indentlines.active,
  },
  {
    "goolord/alpha-nvim",
  },
  {
    "folke/tokyonight.nvim",
  },
  {
    "lunarvim/darkplus.nvim",
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      if saturn.plugins.cmp then
        require('saturn.plugins.core.cmp').setup()
      end
    end,
    require = { "L3MON4D3/LuaSnip" },
  },
  {
    "hrsh7th/cmp-buffer",
  },
  {
    "hrsh7th/cmp-path",
  },
  {
    "saadparwaiz1/cmp_luasnip",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "hrsh7th/cmp-nvim-lua",
  },
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
  },
  {
    "rafamadriz/friendly-snippets",
  },
  {
    "neovim/nvim-lspconfig",
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("saturn.plugins.core.mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
  },
  {
    "tamago324/nlsp-settings.nvim",
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require('saturn.plugins.core.illuminate').setup()
    end,
    disable = not saturn.plugins.illuminate.active,
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      require("saturn.plugins.core.telescope").config()
    end,
    disable = not saturn.plugins.telescope.active,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    require = { "nvim-telescope/telescope.nvim" },
    run = "make",
    disable = not saturn.plugins.telescope.active,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function ()
      require('saturn.plugins.core.treesitter').setup()
    end,
  },
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("saturn.plugins.core.nvim-tree").setup()
    end,
    disable = not saturn.plugins.nvimtree.active,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("saturn.plugins.core.gitsigns").setup()
    end,
    event = "BufRead",
    disable = not saturn.plugins.gitsigns.active,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("saturn.plugins.core.dap").setup()
    end,
    disable = not saturn.plugins.dap.active,
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("saturn.plugins.core.dap").setup_ui()
    end,
    disable = not saturn.plugins.dap.active,
  },
  {
    "ravenxrz/DAPInstall.nvim",
    config = function()
      require('saturn.plugins.core.dap').setup_install()
    end,
    disable = not saturn.plugins.dap.active,
  },
  {
    "Tastyep/structlog.nvim",
  },
  {
    "folke/neodev.nvim",
    module = "neodev",
  },
  {
    "christianchiarulli/lir.nvim",
    config = function ()
      require('saturn.plugins.core.lir').setup()
    end,
    require = { "kyazdani42/nvim-web-devicons" },
    disable = not saturn.plugins.lir.active,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("saturn.plugins.core.whichkey").setup()
    end,
    event = "BufWinEnter",
    disable = not saturn.plugins.whichkey.active,
  },
  {
    "SmiteshP/nvim-navic",
    config = function()
      require('saturn.plugins.core.breadcrumbs').setup()
    end,
    disable = not saturn.plugins.breadcrumbs.active,
  },
  { "b0o/schemastore.nvim" },
  {
    "lunarvim/bigfile.nvim",
    config = function()
      pcall(function()
        require("bigfile").config(saturn.plugins.bigfile.config)
      end)
    end,
    disable = not saturn.plugins.bigfile.active,
  },
}
