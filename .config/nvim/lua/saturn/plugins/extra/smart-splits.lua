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
        on_enter = nil,
        on_leave = nil,
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
  if not saturn.plugins.smart_splits.active then
    return
  end
  local present, smart_splits = pcall(require, "smart-splits")
  if not present then
    return
  end
  smart_splits.setup(saturn.plugins.smart_splits)
  -- Better window navigation
  vim.api.nvim_set_keymap("n", "<C-n>", smart_splits.move_cursor_left(), { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-e>", smart_splits.move_cursor_down(), { noremap = true })
  vim.api.nivm_set_keymap("n", "<C-u>", smart_splits.move_cursor_up(), { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-i>", smart_splits.move_cursor_right(), { noremap = true })
  -- Resize with arrows
  vim.api.nvim_set_keymap("n", "<C-up>", smart_splits.resize_up(), { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-Down>", smart_splits.resize_down(), { noremap = true })
  vim.api.nivm_set_keymap("n", "<C-Left>", smart_splits.resize_left(), { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-Right>", smart_splits.resize_right(), { noremap = true })
  if saturn.plugins.smart_splits.on_config_done then
    saturn.plugins.smart_splits.on_config_done(smart_splits)
  end
end

return M
