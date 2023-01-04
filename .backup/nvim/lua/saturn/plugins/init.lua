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
        config = true,
        enabled = saturn.enable_extra_plugins,
      },
      {
        "ray-x/lsp_signature.nvim",
        config = true,
        enabled = saturn.enable_extra_plugins,
      },

      -- LSP load progress
      {
        "j-hui/fidget.nvim",
        config = true,
        enabled = saturn.enable_extra_plugins,
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
      {
        "tom-anders/telescope-vim-bookmarks.nvim",
        enabled = saturn.enable_extra_plugins,
      },
      --require "harpoon",
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
        "JoosepAlviste/nvim-ts-context-commentstring",
      },
      {
        "p00f/nvim-ts-rainbow",
        enabled = saturn.enable_extra_plugins and saturn.plugins.treesitter.rainbow.enable,
      },
      {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
        enabled = saturn.enable_extra_plugins,
      },
      {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        enabled = saturn.enable_extra_plugins,
      },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        enabled = saturn.enable_extra_plugins,
      },
      {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = saturn.enable_extra_plugins,
      },
      -- {
      --   "Badhi/nvim-treesitter-cpp-tools",
      --   ft = { "c", "cpp", "objc", "objcpp" },
      --   enabled = saturn.enable_extra_plugins,
      -- },
      {
        "m-demare/hlargs.nvim",
        enabled = saturn.enable_extra_plugins,
        config = {
          excluded_argnames = {
            usages = {
              lua = { "self", "use" },
            },
          },
        },
      },
    },
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
    dependencies = {
      {
        "f-person/git-blame.nvim",
        enabled = saturn.enable_extra_plugins,
      },
    },
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
      { "mxsdev/nvim-dap-vscode-js" },
      { "mfussenegger/nvim-dap-python", ft = "python" },
      { "leoluz/nvim-dap-go", ft = "go" },
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
  require("saturn.plugins.trouble"),
  -- Magit like
  require("saturn.plugins.neogit"),
  -- Diff
  require("saturn.plugins.diffview"),
  -- Symbols
  require("saturn.plugins.symbols-outline"),
  -- Search
  require("saturn.plugins.spectre"),
  -- Motion
  require("saturn.plugins.hop"),
  {
    "karb94/neoscroll.nvim",
    config = true,
    event = "VeryLazy",
    enable = saturn.enable_extra_plugins,
  },
  -- Splits
  -- require("saturn.plugins.smart-splits"),
  -- Windows Resize not change radio
  {
    "kwkarlwang/bufresize.nvim",
    config = true,
    enabled = saturn.enable_extra_plugins,
  },
  require("saturn.plugins.notify"),
  -- require("saturn.plugins.noice"),
  -- Neovim Org mode
  {
    "nvim-neorg/neorg",
    ft = "norg",
    config = {
      load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
        ["core.norg.completion"] = {
          config = { engine = "nvim-cmp" },
        },
        ["core.integrations.nvim-cmp"] = {},
      },
    },
  },
  require("saturn.plugins.dressing"),
  -- Cycling buffer switcher
  require("saturn.plugins.cybu"),
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  require("saturn.plugins.colorizer"),
  require("saturn.plugins.true-zen"),
  {
    "kylechui/nvim-surround",
    version = "*",
    sonfig = true,
    event = "InsertEnter",
  },
  -- require("harpoon"),
  -- require("lab"),
  -- Preview number Jump
  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
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
  -- require("saturn.plugins.dial"),
  { "jose-elias-alvarez/typescript.nvim", ft = "typescript" },
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
    config = true,
  },
  require("saturn.plugins.window-picker"),
  -- Folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      { "kevinhwang91/promise-async" },
    },
    config = true,
  },
  {
    "anuvyklack/keymap-amend.nvim",
    config = function()
      local keymap = vim.keymap
      keymap.amend = require("keymap-amend")

      keymap.amend("n", "<Esc>", function(original)
        if vim.v.hlsearch and vim.v.hlsearch == 1 then
          vim.cmd("noh")
        end
        original()
      end, { desc = "disable search highlight" })
    end,
    event = "BufRead",
  },
  -- Browser insert box use neovim
  {
    "glacambre/firenvim",
    lazy = false,
    enabled = saturn.enable_extra_plugins,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    init = function()
      if vim.g.started_by_firenvim then
        vim.g.firenvim_config = {
          localSettings = {
            [".*"] = {
              cmdline = "none",
            },
          },
        }
        vim.opt.laststatus = 0
        vim.api.nvim_create_autocmd("UIEnter", {
          once = true,
          callback = function()
            vim.go.lines = 20
          end,
        })
        -- vim.cmd([[au BufEnter github.com_*.txt set filetype=markdown]])
      end
    end,
  },
  { "mfussenegger/nvim-jdtls", ft = "java" },
  {
    "christianchiarulli/rust-tools.nvim",
    branch = "modularize_and_inlay_rewrite",
    ft = "rust",
  },
  -- rust crates
  require("saturn.plugins.crates"),
  -- open file in last edit place
  { "ethanholz/nvim-lastplace", config = true, lazy = false, priority = 990 },
  -- Translater
  {
    "potamides/pantran.nvim",
    config = function()
      require("pantran").setup({
        controls = {
          mappings = {
            edit = {
              n = {
                -- Use this table to add additional mappings for the normal mode in
                -- the translation window. Either strings or function references are
                -- supported.
                ["e"] = "gj",
                ["u"] = "gk",
              },
              i = {
                -- Similar table but for insert mode. Using 'false' disables
                -- existing keybindings.
                ["<C-y>"] = false,
                ["<C-a>"] = require("pantran.ui.actions").yank_close_translation,
              },
            },
            -- Keybindings here are used in the selection window.
            select = {
              n = {
                -- ...
              },
            },
          },
        },
      })
    end,
  },
  -- OpenAI
  require("saturn.plugins.magic"),
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Comment",
      },
    },
    config = { snippet_engine = "luasnip" },
    dependencies = { "nvim-treesitter" },
    version = "*",
  },
  -- Refactoring
  require("saturn.plugins.refactoring"),
  {
    "MattesGroeger/vim-bookmarks",
    enabled = saturn.enable_extra_plugins,
    cmd = {
      "BookmarkToggle",
      "BookmarkAnnotate",
      "BookmarkNext",
      "BookmarkPrev",
      "BookmarkShowAll",
      "BookmarkClear",
      "BookmarkClearAll",
      "BookmarkMoveUp",
      "BookmarkMoveDown",
      "BookmarkMoveToLine",
      "BookmarkSave",
      "BookmarkLoad",
    },
  },
  require("saturn.plugins.zk"),
  -- Better Quickfix
  require("saturn.plugins.bqf"),
  require("saturn.plugins.yanky"),

  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    init = function()
      saturn.plugins.treesitter.matchup.enable = true
    end,
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
    enable = saturn.enable_extra_plugins,
  },

  {
    "abecodes/tabout.nvim",
    event = "InsertEnter",
    dependencies = {
      "nvim-treesitter",
    },
    config = function()
      saturn.plugins.tabout = {
        tabkey = "<tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<s-tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = false, -- well ...
        completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
          { open = "<", close = ">" },
        },
        ignore_beginning = false, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = { "markdown" }, -- tabout will ignore these filetypes
      }
      require("tabout").setup(saturn.plugins.tabout)
    end,
    enabled = saturn.enable_extra_plugins,
  },
  -- Lsp inline hints
  require("saturn.plugins.inlayhints"),
  -- search box
  require("saturn.plugins.searchbox"),
  -- Session manager
  require("saturn.plugins.persistence"),
  -- Join
  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>" },
    },
    config = { use_default_keymaps = false },
  },
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>R",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },
  require("saturn.plugins.windows"),
}
