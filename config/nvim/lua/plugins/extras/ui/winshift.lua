return {
  {
    "sindrets/winshift.nvim",
    cmd = "WinShift",
    opts = {
      highlight_moving_win = true,
      keymaps = {
        disable_defaults = true, -- Disable the default keymaps
        win_move_mode = {
          ["n"] = "left",
          ["e"] = "down",
          ["i"] = "up",
          ["o"] = "right",
          ["N"] = "far_left",
          ["E"] = "far_down",
          ["I"] = "far_up",
          ["O"] = "far_right",
          ["<left>"] = "left",
          ["<down>"] = "down",
          ["<up>"] = "up",
          ["<right>"] = "right",
          ["<S-left>"] = "far_left",
          ["<S-down>"] = "far_down",
          ["<S-up>"] = "far_up",
          ["<S-right>"] = "far_right",
        },
      },
    },
    keys = { { "<leader>ws", "<CMD>WinShift<CR>", desc = "Window Shift" } },
  },
}
