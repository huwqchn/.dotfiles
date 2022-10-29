return {
  -- Packer can manage itself as an optional plugin
  { "wbthomason/packer.nvim" },
  { "neovim/nvim-lspconfig" },
  { "tamago324/nlsp-settings.nvim" },
  {
    "jose-elias-alvarez/null-ls.nvim",
  },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "williamboman/mason.nvim",
    config = function()
      require("plugins.core.configs.mason").setup()
    end,
  },
  {
    "folke/tokyonight.nvim",
  },
  { "Tastyep/structlog.nvim" },

  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      require("plugins.core.configs.telescope").setup()
    end,
    disable = not saturn.plugins.core.telescope.active,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    run = "make",
    disable = not saturn.plugins.core.telescope.active,
  },
  -- Install nvim-cmp, and buffer source as a dependency
  {
    "hrsh7th/nvim-cmp",
    config = function()
      if saturn.plugins.core.cmp then
        require("plugins.core.configs.cmp").setup()
      end
    end,
    requires = {
      "L3MON4D3/LuaSnip",
    },
  },
  {
    "rafamadriz/friendly-snippets",
    disable = not saturn.plugins.core.luasnip.sources.friendly_snippets,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { "~/.config/nvim/snippets" },
      }
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "saadparwaiz1/cmp_luasnip",
  },
  {
    "hrsh7th/cmp-buffer",
  },
  {
    "hrsh7th/cmp-path",
  },
  {
    "folke/neodev.nvim",
    module = "neodev",
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    config = function()
      require("plugins.core.configs.autopairs").setup()
    end,
    disable = not saturn.plugins.core.autopairs.active,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- run = ":TSUpdate",
    config = function()
      require("plugins.core.configs.treesitter").setup()
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufReadPost",
  },

  -- NvimTree
  {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    config = function()
      require("plugins.core.configs.nvimtree").setup()
    end,
    disable = not saturn.plugins.core.nvimtree.active,
  },
  -- Lir
  {
    "christianchiarulli/lir.nvim",
    config = function()
      require("plugins.core.configs.lir").setup()
    end,
    requires = { "kyazdani42/nvim-web-devicons" },
    disable = not saturn.plugins.core.lir.active,
  },
  {
    "lewis6991/gitsigns.nvim",

    config = function()
      require("plugins.core.configs.gitsigns").setup()
    end,
    event = "BufRead",
    disable = not saturn.plugins.core.gitsigns.active,
  },

  -- Whichkey
  {
    "folke/which-key.nvim",
    config = function()
      require("plugins.core.configs.which-key").setup()
    end,
    event = "BufWinEnter",
    disable = not saturn.plugins.core.which_key.active,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("plugins.core.configs.comment").setup()
    end,
    disable = not saturn.plugins.core.comment.active,
  },

  -- project.nvim
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.core.configs.project").setup()
    end,
    disable = not saturn.plugins.core.project.active,
  },

  -- Icons
  {
    "kyazdani42/nvim-web-devicons",
    disable = not saturn.use_icons,
  },

  -- Status Line and Bufferline
  {
    -- "hoob3rt/lualine.nvim",
    "nvim-lualine/lualine.nvim",
    -- "Lunarvim/lualine.nvim",
    config = function()
      require("plugins.core.configs.lualine").setup()
    end,
    disable = not saturn.plugins.core.lualine.active,
  },

  -- breadcrumbs
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("plugins.core.configs.breadcrumbs").setup()
    end,
    disable = not saturn.plugins.core.breadcrumbs.active,
  },

  {
    "akinsho/bufferline.nvim",
    config = function()
      require("plugins.core.configs.bufferline").setup()
    end,
    branch = "main",
    event = "BufWinEnter",
    disable = not saturn.plugins.core.bufferline.active,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    -- event = "BufWinEnter",
    config = function()
      require("plugins.core.configs.dap").setup()
    end,
    disable = not saturn.plugins.core.dap.active,
  },

  -- Debugger user interface
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("plugins.core.configs.dap").setup_ui()
    end,
    disable = not saturn.plugins.core.dap.active,
  },

  -- alpha
  {
    "goolord/alpha-nvim",
    config = function()
      require("plugins.core.configs.alpha").setup()
    end,
    disable = not saturn.plugins.core.alpha.active,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    event = "BufWinEnter",
    branch = "main",
    config = function()
      require("plugins.core.configs.terminal").setup()
    end,
    disable = not saturn.plugins.core.terminal.active,
  },

  -- SchemaStore
  {
    "b0o/schemastore.nvim",
  },

  {
    "RRethy/vim-illuminate",
    config = function()
      require("plugins.core.configs.illuminate").setup()
    end,
    disable = not saturn.plugins.core.illuminate.active,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.core.configs.indentlines").setup()
    end,
    disable = not saturn.plugins.core.indentlines.active,
  },
}
