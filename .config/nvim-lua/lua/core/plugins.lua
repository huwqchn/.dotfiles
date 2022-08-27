local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
  return string.format('require("config/%s")', name)
end

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- An implementation of the Popup API from vim in Neovim
  -- Useful lua function used ny lots of plugins
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = get_config("telescope"),
  })

  use({ "jvgrootveld/telescope-zoxide" })
  use({ "crispgm/telescope-heading.nvim" })
  use({ "LinArcX/telescope-env.nvim" })
  use({ "nvim-telescope/telescope-symbols.nvim" })
  use({ "nvim-telescope/telescope-file-browser.nvim" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope-packer.nvim" })
  use({ "nvim-telescope/telescope-ui-select.nvim" })
  use({ "rcarriga/nvim-notify", config = get_config("notify") })

  use({ "kyazdani42/nvim-tree.lua", config = get_config("nvim-tree") })

  use({ "numToStr/Navigator.nvim", config = get_config("navigator") })

  use({
    "akinsho/nvim-bufferline.lua",
    requires = "kyazdani42/nvim-web-devicons",
    event = "BufRead",
    config = get_config("bufferline"),
  })

  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    event = "VimEnter",
    config = get_config("lualine"),
  })

  use({ "windwp/nvim-autopairs", config = get_config("autopairs") })

  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = get_config("alpha"),
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = get_config("indent-blankline"),
  })

  use("famiu/bufdelete.nvim")

  -- lsp
  use({ "neovim/nvim-lspconfig", config = get_config("lsp") })

  use({ "williamboman/nvim-lsp-installer" })

  use({ "onsails/lspkind-nvim", requires = { "famiu/bufdelete.nvim" } })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    -- config = get_config("null-ls"),
  })

  use({
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    config = get_config("symbols"),
  })

  use({ "SmiteshP/nvim-navic" })

  -- cmp
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-calc",
      "lukas-reineke/cmp-rg",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = get_config("cmp"),
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    config = get_config("treesitter"),
    run = ":TSUpdate",
  })

  use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })

  use({ "RRethy/nvim-treesitter-endwise", after = "nvim-treesitter" })

  use({ "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" })

  use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })

  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })

  use({ "mfussenegger/nvim-ts-hint-textobject" })

  use({ "ahmedkhalf/project.nvim", config = get_config("project") })

  use("folke/zen-mode.nvim")

  -- Colorschemes
  use({ "folke/tokyonight.nvim", config = get_config("colorscheme") })

  use({
    "norcalli/nvim-colorizer.lua",
    config = get_config("colorizer"),
    event = "BufRead",
  })
  -- which key
  use({ "folke/which-key.nvim", config = get_config("which-key") })

  use({ "RRethy/vim-illuminate", config = get_config("illuminate") })

  -- Terminal Integration
  use({ "akinsho/toggleterm.nvim", config = get_config("toggleterm") })

  -- requirement for Neogit
  use({
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
    config = get_config("diffview"),
  })

  -- Git
  use({
    "TimUntersberger/neogit",
    requires = { "nvim-lua/plenary.nvim" },
    cmd = "Neogit",
    config = get_config("neogit"),
  })

  use({ "f-person/git-blame.nvim", config = get_config("git-blame") })

  use({ "tpope/vim-fugitive" }) -- yeah this is not lua but one of the best Vim plugins ever

  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = get_config("gitsigns"),
  })

  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = get_config("trouble"),
  })

  use({ "rhysd/conflict-marker.vim" })

  use({ "edluffy/specs.nvim", config = get_config("specs") })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
