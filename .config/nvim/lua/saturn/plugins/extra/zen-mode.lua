local M = {}

function M.config()
  saturn.plugins.zen_mode = {
    active = true,
    on_config_done = nil,
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
      tmux = { enabled = false },
      twilight = { enabled = false },
    },
    on_open = function()
      require("lsp-inlayhints").toggle()
      vim.g.cmp_active = false
      vim.cmd [[LspStop]]
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
      vim.cmd [[LspStart]]
      require("saturn.plugins.extra.winbar").create_winbar()
    end,
  }
  saturn.plugins.whichkey.mappings["Z"] = { "<cmd>ZenMode<cr>", "Zen Mode" }
end

function M.setup()
  local status_ok, zen_mode = pcall(require, "zen-mode")
  if not status_ok then
    return
  end
  zen_mode.setup(saturn.plugins.zen_mode)
  if saturn.plugins.zen_mode.on_config_done then
    saturn.plugins.zen_mode.on_config_done(zen_mode)
  end
end

return M
