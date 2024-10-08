return {
  -- zen
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    opts = {
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
        -- pcall(function()
        -- 	require("lsp-inlayhints").toggle()
        -- end)
        pcall(function()
          require("scrollbar.utils").toggle()
        end)
        vim.g.cmp_active = false
        vim.cmd([[LspStop]])
        vim.opt.relativenumber = false
      end,
      on_close = function()
        -- pcall(function()
        -- 	require("lsp-inlayhints").toggle()
        -- end)
        pcall(function()
          require("scrollbar.utils").toggle()
        end)
        vim.g.cmp_active = true
        vim.cmd([[LspStart]])
        vim.opt.relativenumber = true
      end,
    },
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight" },
    keys = {
      { "<leader>Z", "<cmd>Twilight<cr>", desc = "Twilight" },
    },
    config = true,
  },
}
