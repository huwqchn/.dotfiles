-- local require = require("saturn.utils.require").require
local core_plugins = {
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
      require("saturn.core.mason").setup()
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
      require("saturn.core.telescope").setup()
    end,
    disable = not saturn.builtin.telescope.active,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    requires = { "nvim-telescope/telescope.nvim" },
    run = "make",
    disable = not saturn.builtin.telescope.active,
  },
  -- Install nvim-cmp, and buffer source as a dependency
  {
    "hrsh7th/nvim-cmp",
    config = function()
      if saturn.builtin.cmp then
        require("saturn.core.cmp").setup()
      end
    end,
    requires = {
      "L3MON4D3/LuaSnip",
    },
  },
  {
    "rafamadriz/friendly-snippets",
    disable = not saturn.builtin.luasnip.sources.friendly_snippets,
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local utils = require "saturn.utils"
      local paths = {}
      if saturn.builtin.luasnip.sources.friendly_snippets then
        paths[#paths + 1] = utils.join_paths(get_runtime_dir(), "site", "pack", "packer", "start", "friendly-snippets")
      end
      local user_snippets = utils.join_paths(get_config_dir(), "snippets")
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
      require("saturn.core.autopairs").setup()
    end,
    disable = not saturn.builtin.autopairs.active,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- run = ":TSUpdate",
    config = function()
      require("saturn.core.treesitter").setup()
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
      require("saturn.core.nvimtree").setup()
    end,
    disable = not saturn.builtin.nvimtree.active,
  },
  -- Lir
  {
    "christianchiarulli/lir.nvim",
    config = function()
      require("saturn.core.lir").setup()
    end,
    requires = { "kyazdani42/nvim-web-devicons" },
    disable = not saturn.builtin.lir.active,
  },
  {
    "lewis6991/gitsigns.nvim",

    config = function()
      require("saturn.core.gitsigns").setup()
    end,
    event = "BufRead",
    disable = not saturn.builtin.gitsigns.active,
  },

  -- Whichkey
  {
    "folke/which-key.nvim",
    config = function()
      require("saturn.core.which-key").setup()
    end,
    event = "BufWinEnter",
    disable = not saturn.builtin.which_key.active,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("saturn.core.comment").setup()
    end,
    disable = not saturn.builtin.comment.active,
  },

  -- project.nvim
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("saturn.core.project").setup()
    end,
    disable = not saturn.builtin.project.active,
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
      require("saturn.core.lualine").setup()
    end,
    disable = not saturn.builtin.lualine.active,
  },

  -- breadcrumbs
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("saturn.core.breadcrumbs").setup()
    end,
    disable = not saturn.builtin.breadcrumbs.active,
  },

  {
    "akinsho/bufferline.nvim",
    config = function()
      require("saturn.core.bufferline").setup()
    end,
    branch = "main",
    event = "BufWinEnter",
    disable = not saturn.builtin.bufferline.active,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    -- event = "BufWinEnter",
    config = function()
      require("saturn.core.dap").setup()
    end,
    disable = not saturn.builtin.dap.active,
  },

  -- Debugger user interface
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("saturn.core.dap").setup_ui()
    end,
    disable = not saturn.builtin.dap.active,
  },

  -- alpha
  {
    "goolord/alpha-nvim",
    config = function()
      require("saturn.core.alpha").setup()
    end,
    disable = not saturn.builtin.alpha.active,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    event = "BufWinEnter",
    branch = "main",
    config = function()
      require("saturn.core.terminal").setup()
    end,
    disable = not saturn.builtin.terminal.active,
  },

  -- SchemaStore
  {
    "b0o/schemastore.nvim",
  },

  {
    "RRethy/vim-illuminate",
    config = function()
      require("saturn.core.illuminate").setup()
    end,
    disable = not saturn.builtin.illuminate.active,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("saturn.core.indentlines").setup()
    end,
    disable = not saturn.builtin.indentlines.active,
  },

  {
    "lunarvim/onedarker.nvim",
    branch = "freeze",
    config = function()
      pcall(function()
        if saturn and saturn.colorscheme == "onedarker" then
          require("onedarker").setup()
          saturn.builtin.lualine.options.theme = "onedarker"
        end
      end)
    end,
    disable = saturn.colorscheme ~= "onedarker",
  },
}

return core_plugins
