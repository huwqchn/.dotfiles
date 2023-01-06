local M = {
  "mrjones2014/smart-splits.nvim",
  enabled = saturn.enable_extra_plugins,
  event = "WinNew",
  keys = {
    -- resizing splits
    { mode = "n", "<C-Left>", require("smart-splits").resize_left, desc = "resize left" },
    { mode = "n", "<C-Down>", require("smart-splits").resize_down, desc = "resize down" },
    { mode = "n", "<C-Up>", require("smart-splits").resize_up, desc = "resize up" },
    { mode = "n", "<C-Right>", require("smart-splits").resize_right, desc = "resize right" },
    -- moving between splits
    { mode = "n", "<C-n>", require("smart-splits").move_cursor_left, desc = "move cursor left" },
    { mode = "n", "<C-e>", require("smart-splits").move_cursor_down, desc = "move cursor down" },
    { mode = "n", "<C-u>", require("smart-splits").move_cursor_up, desc = "move cursor up" },
    { mode = "n", "<C-i>", require("smart-splits").move_cursor_right, desc = "move cursor right" },
  },
}

M.config = function()
  require("smart-splits").setup({
    -- Ignored filetypes (only while resizing)
    ignored_filetypes = {
      "nofile",
      "quickfix",
      "prompt",
      "qf",
    },
    -- Ignored buffer types (only while resizing)
    ignored_buftypes = { "NvimTree" },
    -- the default number of lines/columns to resize by at a time
    default_amount = 3,
    -- when moving cursor between splits left or right,
    -- place the cursor on the same row of the *screen*
    -- regardless of line numbers. False by default.
    -- Can be overridden via function parameter, see Usage.
    move_cursor_same_row = false,
    -- resize mode options
    resize_mode = {
      -- key to exit persistent resize mode
      quit_key = "<ESC>",
      -- keys to use for moving in resize mode
      -- in order of left, down, up' right
      resize_keys = { "n", "e", "u", "i" },
      -- set to true to silence the notifications
      -- when entering/exiting persistent resize mode
      silent = false,
      -- must be functions, they will be executed when
      -- entering or exiting the resize mode
      hooks = {
        on_enter = function()
          vim.notify("Entering resize mode")
        end,
        on_leave = function()
          vim.notify("Exiting resize mode, bye")
          require("bufresize").register()
        end,
      },
    },
    -- ignore these autocmd events (via :h eventignore) while processing
    -- smart-splits.nvim computations, which involve visiting different
    -- buffers and windows. These events will be ignored during processing,
    -- and un-ignored on completed. This only applies to resize events,
    -- not cursor movement events.
    ignored_events = {
      "BufEnter",
      "WinEnter",
    },
    -- enable or disable the tmux integration
    tmux_integration = true,
  })
end

return M
