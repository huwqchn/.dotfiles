return {
  {
    "echasnovski/mini.surround",
    enabled = false,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {
      keymaps = {
        insert = "<C-k>s",
        insert_line = "<C-k>S",
        normal = "s",
        normal_line = "S",
        normal_cur_line = "ss",
        visual = "s",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
      },
    },
  },
}
