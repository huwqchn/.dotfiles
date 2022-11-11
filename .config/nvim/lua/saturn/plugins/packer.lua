local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" } -- Useful lua functions used by lots of plugins
  use { "nvim-lua/popup.nvim", commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac" }
  use { "windwp/nvim-autopairs",
    commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347",
    config = function()
      require("saturn.plugins.autopairs").setup()
    end,
    disable = not saturn.plugins.autopairs.active,
  } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim",
    commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67",
    event = "BufRead",
    config = function()
      require("saturn.plugins.comment").setup()
    end,
    disable = not saturn.plugins.comment.active,
  }
  use { "folke/todo-comments.nvim" }
  use { "JoosepAlviste/nvim-ts-context-commentstring",
    commit = "32d9627123321db65a4f158b72b757bcaef1a3f4",
    event = "BufReadPost",
  }
  use { "kyazdani42/nvim-web-devicons", commit = "563f3635c2d8a7be7933b9e547f7c178ba0d4352", disable = not saturn.use_icons, }
  use { "kyazdani42/nvim-tree.lua",
    -- commit = "7282f7de8aedf861fe0162a559fc2b214383c51c",
    config = function()
      require("saturn.plugins.nvim-tree").setup()
    end,
    disable = not saturn.plugins.nvimtree.active,
  }
  use { "akinsho/bufferline.nvim",
    -- commit = "83bf4dc7bff642e145c8b4547aa596803a8b4dc4",
    config = function()
      require('saturn.plugins.bufferline').setup()
    end,
    branch = "main",
    event = "BufWinEnter",
    disable = not saturn.plugins.bufferline.active,
  }
  use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }
  use { "nvim-lualine/lualine.nvim",
    commit = "a52f078026b27694d2290e34efa61a6e4a690621",
    config = function()
      require('saturn.plugins.lualine').setup()
    end,
    disable = not saturn.plugins.lualine.active,
  }
  use { "akinsho/toggleterm.nvim",
    -- commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda",
    event = "BufWinEnter",
    branch = "main",
    config = function()
      require('saturn.plugins.toggleterm').setup()
    end,
    disable = not saturn.plugins.toggleterm.active,
  }
  use { "ahmedkhalf/project.nvim",
    -- commit = "628de7e433dd503e782831fe150bb750e56e55d6",
    config = function()
      require("saturn.plugins.project").setup()
    end,
    disable = not saturn.plugins.project.active,
  }
  use { "windwp/nvim-spectre" }
  use { "lewis6991/impatient.nvim", commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" }
  use { "lukas-reineke/indent-blankline.nvim",
    commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6",
    config = function()
      require('saturn.plugins.indentline').setup()
    end,
    disable = not saturn.plugins.indentlines.active,
  }
  use { "goolord/alpha-nvim", commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" }

  -- Colorschemes
  use { "folke/tokyonight.nvim", commit = "66bfc2e8f754869c7b651f3f47a2ee56ae557764" }
  use { "lunarvim/darkplus.nvim", commit = "13ef9daad28d3cf6c5e793acfc16ddbf456e1c83" }

  -- cmp plugins
  use {
    "hrsh7th/nvim-cmp",
    commit = "b0dff0ec4f2748626aae13f011d1a47071fe9abc",
    config = function()
      if saturn.plugins.cmp then
        require('saturn.plugins.cmp').setup()
      end
    end,
    require = { "L3MON4D3/LuaSnip" },
  }
  use { "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" } -- buffer completions
  use { "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" } -- path completions
  use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
  use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }
  use { "hrsh7th/cmp-cmdline" } -- cmdline completions
  use { "hrsh7th/cmp-emoji" }
  use { "zbirenbaum/copilot-cmp" }
  use { "tzachar/cmp-tabnine", 
    run = "./install.sh",
    config = function()
      require("saturn.plugins.tabnine").setup()
    end
  }

  -- snippets
  use { "L3MON4D3/LuaSnip", commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" } --snippet engine
  use { "rafamadriz/friendly-snippets",
    commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1",
  } -- a bunch of snippets to use

  -- LSP
  -- use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
  use { "neovim/nvim-lspconfig", commit = "f11fdff7e8b5b415e5ef1837bdcdd37ea6764dda" } -- enable LSP
  use { "williamboman/mason.nvim",
    commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12",
    config = function()
      require("saturn.plugins.mason").setup()
    end,
  }
  use { "williamboman/mason-lspconfig.nvim", commit = "0051870dd728f4988110a1b2d47f4a4510213e31" }
  use { "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" } -- for formatters and linters
  use { "ray-x/lsp_signature.nvim" }


  use { "tamago324/nlsp-settings.nvim", commit = "758adec8e3b3dd0b4f4d5073a0419b9e1daf43f7" }
  use { "RRethy/vim-illuminate",
    -- commit = "a2e8476af3f3e993bb0d6477438aad3096512e42",
    config = function()
      require('saturn.plugins.illuminate').setup()
    end,
    disable = not saturn.plugins.illuminate.active,
  }

  use { "j-hui/fidget.nvim" }
  use { "lvimuser/lsp-inlayhints.nvim" }
  use { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" }


  -- Telescope
  use { "nvim-telescope/telescope.nvim",
    -- commit = "76ea9a898d3307244dce3573392dcf2cc38f340f",
    branch = "0.1.x",
    config = function()
      require("saturn.plugins.telescope").config()
    end,
    disable = not saturn.plugins.telescope.active,
  }
  use { "nvim-telescope/telescope-fzf-native.nvim",
    -- commit = "65c0ee3d4bb9cb696e262bca1ea5e9af3938fc90",
    require = { "nvim-telescope/telescope.nvim" },
    run = "make",
    disable = not saturn.plugins.telescope.active,
  }
  use { "nvim-telescope/telescope-media-files.nvim" }
  use { "tom-anders/telescope-vim-bookmarks.nvim" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter",
    commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
    config = function ()
      require('saturn.plugins.treesitter').setup()
    end,
  }
  use { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" }

  use { "nvim-treesitter/playground" }
  use { "windwp/nvim-ts-autotag" }
  use { "nvim-treesitter/nvim-treesitter-textobjects" }
  -- Git
  use { "lewis6991/gitsigns.nvim",
    -- commit = "f98c85e7c3d65a51f45863a34feb4849c82f240f",
    config = function()
      require("saturn.plugins.gitsigns").setup()
    end,
    -- event = "BufRead",
    -- disable = not saturn.plugins.gitsigns.active,
  }
  use { "f-person/git-blame.nvim" }
  use { "ruifm/gitlinker.nvim" }
  use { "mattn/vim-gist" }
  use { "mattn/webapi-vim" }

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- DAP
  use { "mfussenegger/nvim-dap",
    commit = "6b12294a57001d994022df8acbe2ef7327d30587",
    config = function()
      require("saturn.plugins.dap").setup()
    end,
    disable = not saturn.plugins.dap.active,
  }
  use { "rcarriga/nvim-dap-ui",
    commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13",
    config = function()
      require("saturn.plugins.dap").setup_ui()
    end,
    disable = not saturn.plugins.dap.active,
  }
  use { "ravenxrz/DAPInstall.nvim",
    -- commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de",
    config = function()
      require('saturn.plugins.dap').setup_install()
    end,
    disable = not saturn.plugins.dap.active,
  }

  use { "Tastyep/structlog.nvim", commit = "232a8e26060440e0db9fefba857036442b34227d" }
  use { "folke/neodev.nvim", module = "neodev", commit = "a9ddee2951ee43ca678b45bcc604592ea49a9456" }
  use { "christianchiarulli/lir.nvim",
    config = function ()
      require('saturn.plugins.lir').setup()
    end,
    require = { "kyazdani42/nvim-web-devicons" },
    disable = not saturn.plugins.lir.active,
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require("saturn.plugins.whichkey").setup()
    end,
    event = "BufWinEnter",
    disable = not saturn.plugins.whichkey.active,
  }
  use { "SmiteshP/nvim-navic",
    config = function()
      require('saturn.plugins.breadcrumbs').setup()
    end,
    disable = not saturn.plugins.breadcrumbs.active,
  }
  use { "simrat39/symbols-outline.nvim" }
  use { "b0o/schemastore.nvim" }

  -- extra
  use { "mrjones2014/smart-splits.nvim" }
  use { "kwkarlwang/bufresize.nvim" }
  use { "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require "saturn.plugins.copilot"
      end, 100)
    end,
  }

  -- Utility
  use { "rcarriga/nvim-notify" }
  use { "stevearc/dressing.nvim" }
  use { "ghillb/cybu.nvim" }
  use { "lalitmee/browse.nvim" }

  -- Registers
  use { "tversteeg/registers.nvim" }


  -- markdown
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

  -- colorizer
  use { "norcalli/nvim-colorizer.lua", event = "BufRead" }
  use { "nvim-colortils/colortils.nvim" }

  -- zen mode
  use { "folke/zen-mode.nvim" }

  -- aerial
  use { "stevearc/aerial.nvim" }

  -- surround
  use { "kylechui/nvim-surround" }

  use {
    "abecodes/tabout.nvim",
    wants = { "nvim-treesitter" }, -- or require if not used so far
  }

  -- marks
  use { "christianchiarulli/harpoon" }
  use { "MattesGroeger/vim-bookmarks" }

  -- Note Taking
  use "mickael-menu/zk-nvim"

  -- Session
  use { "rmagatti/auto-session" }
  use { "rmagatti/session-lens" }

    -- Quickfix
  use { "kevinhwang91/nvim-bqf" }

  -- Code Runner
  use "is0n/jaq-nvim"
  use {
    "0x100101/lab.nvim",
    run = "cd js && npm ci",
  }

  -- Github
  use { "pwntester/octo.nvim" }

  -- edit support
  use { "monaqa/dial.nvim" }
  use { "nacro90/numb.nvim" }
  use { "andymass/vim-matchup" }
  use { "karb94/neoscroll.nvim" }
  use { "junegunn/vim-slash" }

  -- Motion
  use { "phaazon/hop.nvim" }

  -- Java
  use { "mfussenegger/nvim-jdtls" }
  
  -- Rust
  use { "christianchiarulli/rust-tools.nvim", branch = "modularize_and_inlay_rewrite" }
  use { "Saecki/crates.nvim" }

  -- Typescript TODO: set this up, also add keybinds to ftplugin
  use { "jose-elias-alvarez/typescript.nvim" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
