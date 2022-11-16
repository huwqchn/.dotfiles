return {
  {
    "folke/todo-comments.nvim",
    config = function()
      require("saturn.plugins.extra.todo-comments").setup()
    end,
    disable = not saturn.plugins.todo_comments.active,
  },
  {
    -- TODO:not working anyway
    "windwp/nvim-spectre",
    config = function()
      require("saturn.plugins.extra.spectre").setup()
    end,
    disable = not saturn.plugins.spectre.active,
  },
  {
    "ggandor/lightspeed.nvim",
    event = "BufRead",
  },
  {
    "hrsh7th/cmp-cmdline"
  },
  {
    "hrsh7th/cmp-emoji"
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup {
        formatters = {
          insert_text = require("copilot_cmp.format").remove_existing,
        },
      }
    end,
  },
  {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    config = function()
      require("saturn.plugins.extra.tabnine").setup()
    end
  },
  {
    "ray-x/lsp_signature.nvim"
  },
  {
    "j-hui/fidget.nvim"
  },
  {
    "lvimuser/lsp-inlayhints.nvim"
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
  },
  {
    "nvim-telescope/telescope-media-files.nvim"
  },
  {
    "tom-anders/telescope-vim-bookmarks.nvim"
  },
  {
    "p00f/nvim-ts-rainbow", after = "nvim-treesitter",
  },
  {
    "nvim-treesitter/playground",
  },
  {
    "windwp/nvim-ts-autotag",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  {
    "f-person/git-blame.nvim"
  },
  {
    "ruifm/gitlinker.nvim"
  },
  {
    "mattn/vim-gist",
  },
  {
    "mattn/webapi-vim",
  },
  {
    "TimUntersberger/neogit",
  },
  {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("saturn.plugins.extra.symbols-outline").setup()
    end,
    disable = not saturn.plugins.symbols_outline.active,
  },
  {
    "mrjones2014/smart-splits.nvim"
  },
  {
    "kwkarlwang/bufresize.nvim",
    disable = true,
  },
  {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("saturn.plugins.extra.copilot").setup()
      end, 100)
    end,
  },
  { "rcarriga/nvim-notify" },
  { "stevearc/dressing.nvim" },
  {
    "ghillb/cybu.nvim",
    branch = "main", -- timely updates
    -- branch = "v1.x", -- won't receive breaking changes
    config = function()
      require("saturn.plugins.extra.cybu").setup()
    end,
    requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim"}, -- optional for icon support
    disable = not saturn.plugins.cybu.active,
  },
  {
    "lalitmee/browse.nvim",
  },
  {
    "tversteeg/registers.nvim",
    disable = true,
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
  -- { "norcalli/nvim-colorizer.lua", event = "BufRead" },
  {  "NvChad/nvim-colorizer.lua", event = "BufRead" },
  { "nvim-colortils/colortils.nvim" },
  { "folke/zen-mode.nvim" },
  { "stevearc/aerial.nvim" },
  { "kylechui/nvim-surround", disable = true, },
  {
    "abecodes/tabout.nvim",
    wants = { "nvim-treesitter" }, -- or require if not used so far
    disable = true,
  },
  {
    "christianchiarulli/harpoon",
    disable = true,
  },
  {
    "MattesGroeger/vim-bookmarks",
    disable = true,
  },
  {
    "mickael-menu/zk-nvim",
    disable = true,
  },
  {
    "rmagatti/auto-session",
    disable = false,
  },
  {
    "rmagatti/session-lens",
    disable = false,
  },
  {
    "kevinhwang91/nvim-bqf",
    config = function()
      require("saturn.plugins.extra.bqf").setup()
    end,
    disable = not saturn.plugins.bqf.active,
  },
  {
    "is0n/jaq-nvim",
    conifg = function()
      require("jaq").setup()
    end,
    disable = not saturn.plugins.jaq.active,
  },
  {
    "ggandor/leap.nvim",
  },
  {
    "0x100101/lab.nvim",
    run = "cd js && npm ci",
    disable = true,
  },
  {
    "pwntester/octo.nvim",
    disable = true,
  },
  {
    "monaqa/dial.nvim",
    config = function()
      require("saturn.plugins.extra.dial").setup()
    end,
    disable = not saturn.plugins.dial.active,
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("numb").setup {
        show_numbers = true, -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
        -- hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
        -- number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
        -- centered_peeking = true, -- Peeked line will be centered relative to window
      }
    end,
  },
  { "andymass/vim-matchup", disable = true },
  { "karb94/neoscroll.nvim" },
  { "junegunn/vim-slash", disable = true },
  { "phaazon/hop.nvim", disable = true },
  { "mfussenegger/nvim-jdtls" },
  { "christianchiarulli/rust-tools.nvim", branch = "modularize_and_inlay_rewrite" },
  {
    "Saecki/crates.nvim",
    tag = "v0.3.0",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      }
    end,
  },
  {
    "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup {
        highlight_on_key = true,
      }
    end,
  },
  { "jose-elias-alvarez/typescript.nvim" },
  { "mxsdev/nvim-dap-vscode-js" },
  { "mfussenegger/nvim-dap-python" },
  { "leoluz/nvim-dap-go" },
  { "olexsmir/gopher.nvim", }
}