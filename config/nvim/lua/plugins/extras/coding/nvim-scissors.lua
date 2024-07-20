return {
  {
    "chrisgrieser/nvim-scissors",
    dependencies = "nvim-telescope/telescope.nvim", -- optional
    opts = {
      snippetDir = "~/.config/nvim/snippets/",
    },
    keys = {
      {
        "<leader>ce",
        function()
          require("scissors").editSnippet()
        end,
        desc = "edit snippet",
      },
      {
        "<leader>cn",
        function()
          require("scissors").addNewSnippet()
        end,
        desc = "add new snippet",
      },
    },
  },
}
