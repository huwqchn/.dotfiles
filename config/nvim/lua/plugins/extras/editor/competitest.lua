return {
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    keys = {
      { "<leader>Ca", "<cmd>CompetiTest add_testcase<cr>", desc = "add Test case" },
      { "<leader>Ce", "<cmd>CompetiTest edit_testcase<cr>", desc = "edit Test case" },
      { "<leader>Cr", "<cmd>CompetiTest run<cr>", desc = "run Test case" },
      { "<leader>CR", "<cmd>CompetiTest run_no_compile<cr>", desc = "run Test case without compile" },
      { "<leader>Cu", "<cmd>CompetiTest show_ui<cr>", desc = "show Test case UI" },
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
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          mode = { "n", "x" },
          { "<leader>C", group = "CompetiTest" },
        },
      },
    },
  },
}
