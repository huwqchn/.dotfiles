return {
  -- set to HEAD for now. I'm sill making too many changes for this repo related to lazy itself
  {
    "folke/lazy.nvim",
    version = false,
    keys = {
      { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Install" },
      { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "Sync" },
      { "<leader>pS", "<cmd>Lazy clear<cr>", desc = "Clear" },
      { "<leader>pc", "<cmd>Lazy clean<cr>", desc = "Clean" },
      { "<leader>pu", "<cmd>Lazy update<cr>", desc = "Update" },
      { "<leader>pp", "<cmd>Lazy profile<cr>", desc = "Profile" },
      { "<leader>pl", "<cmd>Lazy log<cr>", desc = "Log" },
      { "<leader>pd", "<cmd>Lazy debug<cr>", desc = "Debug" },
    },
  },
}
