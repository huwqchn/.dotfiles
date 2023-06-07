return {
  {
    "jackMort/ChatGPT.nvim",
    -- event = "VeryLazy",
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTEditWithInstructions",
    },
    keys = {
      {
        "<leader>ac",
        "<cmd>ChatGPT<cr>",
        desc = "chatgpt",
      },
    },
    opts = {
      keymaps = {
        close = { "<C-c>", "<Esc>" },
        yank_last = "<C-y>",
        scroll_up = "<C-i>",
        scroll_down = "<C-e>",
        toggle_settings = "<C-o>",
        new_session = "<C-n>",
        cycle_windows = "<Tab>",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
