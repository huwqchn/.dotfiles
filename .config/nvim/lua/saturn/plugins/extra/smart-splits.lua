local M = {}

M.config = function()
  saturn.plugins.smart_splits = {
    active = true,
    on_config_done = nil,
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
        on_enter = function() vim.notify('Entering resize mode') end,
        on_leave = function()
          vim.notify('Exiting resize mode, bye')
          require('bufresize').register()
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
  }
end

M.setup = function()
  local present, smart_splits = pcall(require, "smart-splits")
  if not present then
    return
  end
  smart_splits.setup(saturn.plugins.smart_splits)
  -- resizing splits
  vim.keymap.set("n", "<C-Left>", require("smart-splits").resize_left)
  vim.keymap.set("n", "<C-Down>", require("smart-splits").resize_down)
  vim.keymap.set("n", "<C-Up>", require("smart-splits").resize_up)
  vim.keymap.set("n", "<C-Right>", require("smart-splits").resize_right)
  -- moving between splits
  vim.keymap.set("n", "<C-n>", require("smart-splits").move_cursor_left)
  vim.keymap.set("n", "<C-e>", require("smart-splits").move_cursor_down)
  vim.keymap.set("n", "<C-u>", require("smart-splits").move_cursor_up)
  vim.keymap.set("n", "<C-i>", require("smart-splits").move_cursor_right)
  if saturn.plugins.smart_splits.on_config_done then
    saturn.plugins.smart_splits.on_config_done(smart_splits)
  end
end

return M
