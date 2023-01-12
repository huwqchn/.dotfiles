return {
  -- {
  --   "karb94/neoscroll.nvim",
  --   config = true,
  --   event = "VeryLazy",
  -- },
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
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   build = "cd app && npm install",
  --   init = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --   end,
  --   ft = { "markdown" },
  -- },
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
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    config = function()
      require("zen_mode").setup({
        window = {
          backdrop = 1,
          height = 0.9,
          -- width = 0.5,
          width = 80,
          options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
            cursorline = true,
            cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          gitsigns = { enabled = false },
          tmux = { enabled = true },
          twilight = { enabled = true },
        },
        on_open = function()
          require("lsp-inlayhints").toggle()
          vim.g.cmp_active = false
          vim.cmd([[LspStop]])
          vim.opt.relativenumber = false
        end,
        on_close = function()
          require("lsp-inlayhints").toggle()
          vim.g.cmp_active = true
          vim.cmd([[LspStart]])
          vim.opt.relativenumber = true
        end,
      })
    end,
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight" },
    keys = {
      { "<leader>zt", "<cmd>Twilight<cr>", desc = "Twilight" },
    },
    config = true,

  },
  -- session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = false, -- "Name" codes like Blue or blue
          RRGGBBAA = false, -- #RRGGBBAA hex codes
          AARRGGBB = false, -- 0xAARRGGBB hex codes
          rgb_fn = false, -- CSS rgb() and rgba() functions
          hsl_fn = false, -- CSS hsl() and hsla() functions
          css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "background", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = false, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          virtualtext = saturn.icons.ui.Circle,
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
      })

      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = {
          "*.css",
        },
        callback = function()
          require("colorizer").attach_to_buffer(0, { mode = "background", css = true })
        end,
      })
    end,
  },
  --TODO:folding
}
