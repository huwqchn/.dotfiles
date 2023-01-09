local M = {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = {
    { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
  },
}

function M.init()
  saturn.plugins.whichkey.mappings["z"] = { name = "Zen" }
end

function M.config()
  saturn.plugins.zen_mode = {
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
      local present, _ = pcall(vim.api.nvim_set_option_value, "winbar", nil, { scope = "local" })
      if not present then
        return
      end
      if vim.fn.exists("#" .. "_winbar") == 1 then
        vim.cmd("au! " .. "_winbar")
      end
    end,
    on_close = function()
      require("lsp-inlayhints").toggle()
      vim.g.cmp_active = true
      vim.cmd([[LspStart]])
      require("saturn.plugins.extra.winbar").create_winbar()
    end,
  }
  require("zen_mode").setup(saturn.plugins.zen_mode)
end

return M
