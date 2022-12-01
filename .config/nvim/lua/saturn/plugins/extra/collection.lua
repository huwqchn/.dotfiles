return {
  {
    "folke/todo-comments.nvim",
    config = function()
      require("saturn.plugins.extra.todo-comments").setup()
    end,
    disable = not saturn.plugins.todo_comments.active,
  },
  {
    "LukasPietzschmann/telescope-tabs",
    requires = { "nvim-telescope/telescope.nvim" },
  },
  {
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
    "hrsh7th/cmp-cmdline",
  },
  {
    "hrsh7th/cmp-emoji",
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup({
        formatters = {
          insert_text = require("copilot_cmp.format").remove_existing,
        },
      })
    end,
  },
  {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    config = function()
      require("saturn.plugins.extra.tabnine").setup()
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    config = function()
      require("saturn.plugins.extra.trouble").setup()
    end,
    disable = not saturn.plugins.trouble.active,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = function()
      require("saturn.plugins.extra.inlayhints")
      -- require("lsp-inlayhints").setup({
      --   show_parameter_hints = true,
      --   show_parameter_type_hints = true,
      --   show_return_type_hints = true,
      --   show_variable_type_hints = true,
      --   parameter_hints_prefix = "<- ",
      --   parameter_hints_separator = ", ",
      --   other_hints_prefix = "=> ",
      -- })
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  },
  {
    "nvim-telescope/telescope-media-files.nvim",
  },
  {
    "tom-anders/telescope-vim-bookmarks.nvim",
  },
  {
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
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
    "nvim-treesitter/nvim-treesitter-context",
  },
  {
    "f-person/git-blame.nvim",
  },
  {
    "ruifm/gitlinker.nvim",
  },
  {
    "mattn/vim-gist",
  },
  {
    "mattn/webapi-vim",
  },
  {
    "TimUntersberger/neogit",
    config = function()
      require("saturn.plugins.extra.neogit").setup()
    end,
    disable = not saturn.plugins.neogit.active,
  },
  {
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("saturn.plugins.extra.diffview").setup()
    end,
    disable = not saturn.plugins.diffview.active,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("saturn.plugins.extra.symbols-outline").setup()
    end,
    disable = not saturn.plugins.symbols_outline.active,
  },
  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      require("saturn.plugins.extra.smart-splits").setup()
    end,
    disable = not saturn.plugins.smart_splits.active,
  },
  {
    "kwkarlwang/bufresize.nvim",
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
  {
    "rcarriga/nvim-notify",
    config = function()
      require("saturn.plugins.extra.notify").setup()
    end,
    disable = not saturn.plugins.notify.active,
  },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("saturn.plugins.extra.dressing").setup()
    end,
    disable = not saturn.plugins.dressing.active,
  },
  {
    "VonHeikemen/fine-cmdline.nvim",
    config = function()
      require("saturn.plugins.extra.fine-cmdline")
    end,
    requires = {
      { "MunifTanjim/nui.nvim" },
    },
  },
  {
    "romgrk/searchbox.nvim",
    config = function()
      require("saturn.plugins.extra.searchbox")
    end,
    requires = {
      { "MunifTanjim/nui.nvim" },
    },
  },
  {
    "ghillb/cybu.nvim",
    branch = "main", -- timely updates
    -- branch = "v1.x", -- won't receive breaking changes
    config = function()
      require("saturn.plugins.extra.cybu").setup()
    end,
    requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
    disable = not saturn.plugins.cybu.active,
  },
  {
    "lalitmee/browse.nvim",
  },
  {
    "tversteeg/registers.nvim",
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  -- { "norcalli/nvim-colorizer.lua", event = "BufRead" },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("saturn.plugins.extra.colorizer").setup()
    end,
    disable = not saturn.plugins.colorizer.active,
  },
  { "nvim-colortils/colortils.nvim" },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("saturn.plugins.extra.zen-mode").setup()
    end,
    disable = not saturn.plugins.zen_mode.active,
  },
  {
    "Pocco81/true-zen.nvim",
    config = function()
      require("saturn.plugins.extra.true-zen").setup()
    end,
    disable = not saturn.plugins.true_zen,
  },
  {
    "stevearc/aerial.nvim",
    config = function()
      require("saturn.plugins.extra.aerial").setup()
    end,
    disable = not saturn.plugins.aerial.active,
  },
  {
    "kylechui/nvim-surround",
  },
  {
    "abecodes/tabout.nvim",
    wants = { "nvim-treesitter" }, -- or require if not used so far
    config = function()
      require("saturn.plugins.extra.tabout").setup()
    end,
    disable = not saturn.plugins.tabout.active,
  },
  {
    "christianchiarulli/harpoon",
    config = function()
      require("saturn.plugins.extra.harpoon").setup()
    end,
    disable = not saturn.plugins.harpoon.active,
  },
  {
    "MattesGroeger/vim-bookmarks",
  },
  {
    "mickael-menu/zk-nvim",
  },
  {
    "rmagatti/auto-session",
  },
  {
    "rmagatti/session-lens",
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("saturn.plugins.extra.persistence").setup()
    end,
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
    config = function()
      require("saturn.plugins.extra.jaq").setup()
    end,
    disable = not saturn.plugins.jaq.active,
  },
  {
    "ggandor/leap.nvim",
  },
  {
    "0x100101/lab.nvim",
    run = "cd js && npm ci",
    config = function()
      require("saturn.plugins.extra.lab").setup()
    end,
    require = { "nvim-lua/plenary.nvim" },
    disable = not saturn.plugins.lab.active,
  },
  {
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
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
      require("numb").setup({
        show_numbers = true, -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
        -- hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
        -- number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
        -- centered_peeking = true, -- Peeked line will be centered relative to window
      })
    end,
  },
  {
    "andymass/vim-matchup",
  },
  { "karb94/neoscroll.nvim" },
  -- { "junegunn/vim-slash",},
  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("saturn.plugins.extra.hop")
    end,
  },
  { "mfussenegger/nvim-jdtls" },
  { "christianchiarulli/rust-tools.nvim", branch = "modularize_and_inlay_rewrite" },
  {
    "Saecki/crates.nvim",
    tag = "v0.3.0",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("saturn.plugins.extra.crates").setup()
    end,
  },
  {
    "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup({
        highlight_on_key = true,
      })
    end,
  },
  { "jose-elias-alvarez/typescript.nvim" },
  { "mxsdev/nvim-dap-vscode-js" },
  { "mfussenegger/nvim-dap-python" },
  { "leoluz/nvim-dap-go" },
  { "olexsmir/gopher.nvim" },
  {
    "oberblastmeister/neuron.nvim",
  },
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
  },
  { "ellisonleao/glow.nvim" },
  { "ethanholz/nvim-lastplace" },
  {
    "itchyny/vim-cursorword",
    event = { "BufEnter", "BufNewFile" },
    config = function()
      vim.api.nvim_command("augroup user_plugin_cursorword")
      vim.api.nvim_command("autocmd!")
      vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
      vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
      vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
      vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
      vim.api.nvim_command("augroup END")
    end,
  },
  {
    "rmagatti/goto-preview",
  },
  {
    "s1n7ax/nvim-window-picker",
    tag = "v1.*",
    config = function()
      require("saturn.plugins.extra.window-picker").setup()
    end,
    disable = not saturn.plugins.window_picker.active,
  },
  {
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
  },
  {
    "potamides/pantran.nvim",
  },
  -- using packer.nvim
  {
    "jameshiew/nvim-magic",
    config = function()
      require("nvim-magic").setup({
        backends = {
          default = require('nvim-magic-openai').new(),
        },
        use_default_keymap = false
      })
      local vopts = {
        mode = "x",
        prefix = "<leader>",
        silent = true,
        noremap = true,
        nowait = true,
      }
      local vmappings = {
        o = {
          name = "+magic openai",
          o = { "<cmd>lua require('nvim-magic.flows').append_completion(require('nvim-magic').backends.default)<cr>", "append completion" },
          a = { "<cmd>lua require('nvim-magic.flows').suggest_alteration(require('nvim-magic').backends.default)<cr>", "suggest alteration" },
          d = { "<cmd>lua require('nvim-magic.flows').suggest_docstring(require('nvim-magic').backends.default)<cr>", "generating a docstring" },
        },
      }
      require("which-key").register(vmappings, vopts)
    end,
    requires = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "anuvyklack/keymap-amend.nvim",
    config = function()
      local keymap = vim.keymap
      keymap.amend = require('keymap-amend')

      keymap.amend('n', '<Esc>', function(original)
        if vim.v.hlsearch and vim.v.hlsearch == 1 then
          vim.cmd("noh")
        end
        original()
      end, { desc = 'disable search highlight' })
    end,
  },
}
