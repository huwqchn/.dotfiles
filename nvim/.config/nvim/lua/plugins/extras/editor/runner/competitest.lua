return {
  {
    "xeluxee/competitest.nvim",
    keys = {
      { "<leader>cT", "<cmd>CompetiTestRun<cr>", desc = "Run with Test case" },
    },
    opts = {
      picker_ui = {
        mappings = {
          focus_next = { "e", "<down>", "<Tab>" },
          focus_prev = { "i", "<up>", "<S-Tab>" },
          close = { "<esc>", "<C-c>", "q", "Q" },
          submit = { "<cr>" },
        },
      },
      editor_ui = {
        normal_mode_mappings = {
          switch_window = { "<C-n>", "<C-o>", "<C-i>" },
          save_and_close = "<C-s>",
          cancel = { "q", "Q" },
        },
        insert_mode_mappings = {
          switch_window = { "<C-n>", "<C-o>", "<C-i>" },
          save_and_close = "<C-s>",
          cancel = "<C-q>",
        },
      },
    },
  },
}
