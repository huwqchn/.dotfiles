local M = {
  "s1n7ax/nvim-window-picker",
  version = "v1.*",
  enabled = saturn.enable_extra_plugins,
  keys = {
    {
      "<leader>ww",

      function()
        local picker = require("window-picker")
        local picked_window_id = picker.pick_window({
          include_current_win = true,
        }) or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end,
      desc = "Window Picker",
    },
    {
      "<leader>ws",

      function()
        local picker = require("window-picker")
        local window = picker.pick_window({
          include_current_win = false,
        })
        local target_buffer = vim.fn.winbufnr(window)
        -- Set the target window to contain current buffer
        vim.api.nvim_win_set_buf(window, 0)
        -- Set current window to contain target buffer
        vim.api.nvim_win_set_buf(0, target_buffer)
      end,
      desc = "Window Swap",
    },
  },

  config = {
    selection_chars = "TNSERIAOCMPLFUWYQ;",
  },
}

return M
