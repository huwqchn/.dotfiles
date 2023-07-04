return {
  {
    "s1n7ax/nvim-window-picker",
    version = "v1.*",
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
        desc = "Pick a window",
      },
      { "sw", "<leader>ww", remap = true, desc = "Pick window" },
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
        desc = "Swap a window",
      },
      { "sW", "<leader>ws", remap = true, desc = "Swap window" },
    },
    opts = {
      autoselect_one = true,
      include_current = false,
      filter_rules = {
        -- filter using buffer options
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = { "neo-tree", "neo-tree-popup", "notify", "NvimTree" },

          -- if the buffer type is one of following, the window will be ignored
          buftype = { "terminal", "quickfix" },
        },
      },
      other_win_hl_color = "#e35e4f",
      selection_chars = "ASTNEIOXFPLUDHKMCV",
    },
    config = function(_, opts)
      require("window-picker").setup(opts)
    end,
  },
}
