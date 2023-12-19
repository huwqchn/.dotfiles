return {

  -- git blame
  {
    "f-person/git-blame.nvim",
    event = "BufReadPre",
    opts = function()
      vim.g.gitblame_date_format = "%r"
    end,
    keys = {
      { "<leader>ug", "<CMD>GitBlameToggle<CR>", desc = "Toggle GitBlame" },
    },
  },

  -- git conflict
  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    opts = {},
  },

  -- git ignore
  {
    "wintermute-cell/gitignore.nvim",
    keys = {
      {
        "<leader>gi",
        function()
          require("gitignore").generate()
        end,
        desc = "gitignore",
      },
    },
  },
}
