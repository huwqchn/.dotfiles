return {
  { "jose-elias-alvarez/null-ls.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },
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

  -- Lir
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

  -- Icons
  {
    "kyazdani42/nvim-web-devicons",
    enabled = saturn.use_icons,
  },

  { "mfussenegger/nvim-dap-python", ft = "python" },
  { "leoluz/nvim-dap-go", ft = "go" },
  { "mxsdev/nvim-dap-vscode-js", ft = { "javascript", "typescript" } },
  -- SchemaStore
  { "b0o/schemastore.nvim" },

  {
    "karb94/neoscroll.nvim",
    config = true,
    event = "VeryLazy",
    enable = saturn.enable_extra_plugins,
  },
  -- Windows Resize not change radio
  -- {
  --   "kwkarlwang/bufresize.nvim",
  --   config = true,
  --   enabled = saturn.enable_extra_plugins,
  --   event = "BufAdd",
  -- },
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
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  "folke/twilight.nvim",
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
  { "jose-elias-alvarez/typescript.nvim", ft = "typescript", config = true },
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
    "anuvyklack/keymap-amend.nvim",
    event = "BufRead",
    keys = {
      {
        "<Esc>",
        function()
          local keymap = vim.keymap
          keymap.amend = require("keymap-amend")

          keymap.amend("n", "<Esc>", function(original)
            if vim.v.hlsearch and vim.v.hlsearch == 1 then
              vim.cmd("noh")
            end
            original()
          end, { desc = "disable search highlight" })
        end,
        mode = "n",
        desc = "disable search highlight",
      },
    },
    enabled = saturn.enable_extra_plugins,
  },
  { "mfussenegger/nvim-jdtls", ft = "java" },
  {
    "christianchiarulli/rust-tools.nvim",
    branch = "modularize_and_inlay_rewrite",
    ft = "rust",
  },
  -- open file in last edit place
  { "ethanholz/nvim-lastplace", config = true, event = "BufRead" },
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
  },
  {
    "MattesGroeger/vim-bookmarks",
    enabled = saturn.enable_extra_plugins,
    init = function()
      saturn.plugins.whichkey.mappings.m = {
        name = "Marks",
      }
    end,
    keys = {
      { "<leader>ma", "<cmd>silent BookmarkAnnotate<cr>", desc = "Annotate" },
      { "<leader>mc", "<cmd>silent BookmarkClear<cr>", desc = "Clear" },
      { "<leader>mt", "<cmd>silent BookmarkToggle<cr>", desc = "Toggle" },
      { "<leader>me", "<cmd>silent BookmarkNext<cr>", desc = "Next" },
      { "<leader>mu", "<cmd>silent BookmarkPrev<cr>", desc = "Prev" },
      { "<leader>ml", "<cmd>silent BookmarkShowAll<cr>", desc = "Show All" },
      { "<leader>mx", "<cmd>BookmarkClearAll<cr>", desc = "Clear All" },
    },
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
    config = {
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
    },
    enabled = saturn.enable_extra_plugins,
  },
  -- Join
  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>" },
    },
    config = { use_default_keymaps = false },
  },
  -- Structural Replace
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
  -- {
  --   "smjonas/inc-rename.nvim",
  --   cmd = "IncRename",
  --   config = true,
  --   enabled = saturn.enable_extra_plugins,
  -- },
  -- {
  --   "rmagatti/goto-preview",
  --   config = true,
  --   enabled = saturn.enable_extra_plugins,
  -- },
}
