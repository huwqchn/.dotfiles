local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufRead",
  dependencies = {
    {
      "f-person/git-blame.nvim",
      enabled = saturn.enable_extra_plugins,
    },
  },
  keys = {
    { "<leader>ge", "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", desc = "Next Hunk" },
    { "<leader>gu", "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", desc = "Prev Hunk" },
    { "<leader>gb", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame" },
    { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk" },
    { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk" },
    { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
    { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk" },
    { "<leader>gl", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk" },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff" },
  },
}

saturn.plugins.gitsigns = {
  active = true,
  on_config_done = nil,
  opts = {
    signs = {
      add = {
        hl = "GitSignsAdd",
        text = saturn.icons.ui.BoldLineLeft,
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn",
      },
      change = {
        hl = "GitSignsChange",
        text = saturn.icons.ui.BoldLineLeft,
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      delete = {
        hl = "GitSignsDelete",
        text = saturn.icons.ui.Triangle,
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      topdelete = {
        hl = "GitSignsDelete",
        text = saturn.icons.ui.Triangle,
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      changedelete = {
        hl = "GitSignsChange",
        text = saturn.icons.ui.BoldLineLeft,
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
    },
    numhl = false,
    linehl = false,
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,
    },
    signcolumn = true,
    word_diff = false,
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
      relative_time = false,
    },
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    sign_priority = 6,
    update_debounce = 200,
    status_formatter = nil, -- Use default
    yadm = { enable = false },
  },
}

function M.init()
  saturn.plugins.whichkey.mappings.g = {
    name = "Git",
  }
end

function M.config()
  local gitsigns = pcall(require, "gitsigns")

  gitsigns.setup(saturn.plugins.gitsigns.opts)
  if saturn.plugins.gitsigns.on_config_done then
    saturn.plugins.gitsigns.on_config_done(gitsigns)
  end
end

return M
