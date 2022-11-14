return {
  {
    "wbthomason/packer.nvim",
    -- commit = "6afb67460283f0e990d35d229fd38fdc04063e0a"
  },
  {
    "nvim-lua/plenary.nvim",
    -- commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" 
  },
  {
    "nvim-lua/popup.nvim",
    -- commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac" 
  },
  {
    "windwp/nvim-autopairs",
    -- commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347",
    config = function()
      require("saturn.plugins.core.autopairs").setup()
    end,
    disable = not saturn.plugins.autopairs.active,
  },
  {
    "numToStr/Comment.nvim",
    -- commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67",
    event = "BufRead",
    config = function()
      require("saturn.plugins.core.comment").setup()
    end,
    disable = not saturn.plugins.comment.active,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    -- commit = "32d9627123321db65a4f158b72b757bcaef1a3f4",
    event = "BufReadPost",
  },
  {
    "kyazdani42/nvim-web-devicons",
    -- commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352",
    disable = not saturn.use_icons,
  },
  {
    "akinsho/bufferline.nvim",
    -- commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4",
    config = function()
      require('saturn.plugins.core.bufferline').setup()
    end,
    branch = "main",
    event = "BufWinEnter",
    disable = not saturn.plugins.bufferline.active,
  },
  {
    "moll/vim-bbye",
    -- commit = "25ef93ac5a87526111f43e5110675032dbcacf56"
  },
  {
    "nvim-lualine/lualine.nvim",
    -- commit = "a52f078026b27694d2290e34efa61a6e4a690621",
    config = function()
      require('saturn.plugins.core.lualine').setup()
    end,
    disable = not saturn.plugins.lualine.active,
  },
  {
    "akinsho/toggleterm.nvim",
    -- commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda",
    event = "BufWinEnter",
    branch = "main",
    config = function()
      require('saturn.plugins.core.toggleterm').setup()
    end,
    disable = not saturn.plugins.toggleterm.active,
  },
  {
    "ahmedkhalf/project.nvim",
    -- commit = "628de7e433dd503e782831fe150bb750e56e55d6",
    config = function()
      require("saturn.plugins.core.project").setup()
    end,
    disable = not saturn.plugins.project.active,
  },
  {
    "lewis6991/impatient.nvim",
    -- commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    -- commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6",
    config = function()
      require('saturn.plugins.core.indentline').setup()
    end,
    disable = not saturn.plugins.indentlines.active,
  },
  {
    "goolord/alpha-nvim",
    -- commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31"
  },
  {
    "folke/tokyonight.nvim",
    -- commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764", 
  },
  {
    "lunarvim/darkplus.nvim",
    -- commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83"
  },
  {
    "hrsh7th/nvim-cmp",
    -- commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc",
    config = function()
      if saturn.plugins.cmp then
        require('saturn.plugins.core.cmp').setup()
      end
    end,
    require = { "L3MON4D3/LuaSnip" },
  },
  {
    "hrsh7th/cmp-buffer",
    -- commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
  },
  {
    "hrsh7th/cmp-path",
    -- commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1"
  },
  {
    "saadparwaiz1/cmp_luasnip",
    -- commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36"
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    -- commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8"
  },
  {
    "hrsh7th/cmp-nvim-lua",
    -- commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21"
  },
  {
    "L3MON4D3/LuaSnip",
    -- commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84"
    config = function()
      local paths = {}
      if lvim.plugins.luasnip.sources.friendly_snippets then
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
    -- commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1",
  },
  {
    "neovim/nvim-lspconfig",
    commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda"
  },
  {
    "williamboman/mason.nvim",
    commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12",
    config = function()
      require("saturn.plugins.core.mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    commit = "0051870dd728f4988110a1b2d47f4a4510213e31"
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    commit = "c0c19f32b614b3921e17886c541c13a72748d450"
  },
  {
    "tamago324/nlsp-settings.nvim",
    commit = "758adec8e3b3dd0b4f4d5073a0419b9e1daf43f7"
  },
  {
    "RRethy/vim-illuminate",
    -- commit = "a2e8476af3f3e993bb0d6477438aad3096512e42",
    config = function()
      require('saturn.plugins.core.illuminate').setup()
    end,
    disable = not saturn.plugins.illuminate.active,
  },
  {
    "nvim-telescope/telescope.nvim",
    -- commit = "76ea9a898d3307244dce3573392dcf2cc38f340f",
    branch = "0.1.x",
    config = function()
      require("saturn.plugins.core.telescope").config()
    end,
    disable = not saturn.plugins.telescope.active,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    -- commit = "65c0ee3d4bb9cb696e262bca1ea5e9af3938fc90",
    require = { "nvim-telescope/telescope.nvim" },
    run = "make",
    disable = not saturn.plugins.telescope.active,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
    config = function ()
      require('saturn.plugins.core.treesitter').setup()
    end,
  },
  {
    "kyazdani42/nvim-tree.lua",
    -- commit = "7282f7de8aedf861fe0162a559fc2b214383c51c",
    config = function()
      require("saturn.plugins.core.nvim-tree").setup()
    end,
    disable = not saturn.plugins.nvimtree.active,
  },
  {
    "lewis6991/gitsigns.nvim",
    -- commit = "f98c85e7c3d65a51f45863a34feb4849c82f240f",
    config = function()
      require("saturn.plugins.core.gitsigns").setup()
    end,
    event = "BufRead",
    disable = not saturn.plugins.gitsigns.active,
  },
  {
    "mfussenegger/nvim-dap",
    -- commit = "6b12294a57001d994022df8acbe2ef7327d30587",
    config = function()
      require("saturn.plugins.core.dap").setup()
    end,
    disable = not saturn.plugins.dap.active,
  },
  {
    "rcarriga/nvim-dap-ui",
    -- commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13",
    config = function()
      require("saturn.plugins.core.dap").setup_ui()
    end,
    disable = not saturn.plugins.dap.active,
  },
  {
    "ravenxrz/DAPInstall.nvim",
    -- commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de",
    config = function()
      require('saturn.plugins.core.dap').setup_install()
    end,
    disable = not saturn.plugins.dap.active,
  },
  {
    "Tastyep/structlog.nvim",
    -- commit = "232a8e26060440e0db9fefba857036442b34227d"
  },
  {
    "folke/neodev.nvim",
    module = "neodev",
    -- commit = "a9ddee2951ee43ca678b45bcc604592ea49a9456"
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
}
