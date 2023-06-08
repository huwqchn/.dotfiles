return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>r"] = { name = "+refactor" },
      },
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    keys = {
      {
        "<leader>r",
        function()
          require("refactoring").select_refactor()
        end,
        mode = "v",
        noremap = true,
        silent = true,
        expr = false,
        desc = "refactor seletion",
      },
      {
        "<leader>rb",
        function()
          require("refactoring").refactor("Extract Block")
        end,
        mode = "n",
        noremap = true,
        silent = true,
        expr = false,
        desc = "extract block",
      },
      {
        "<leader>rB",
        function()
          require("refactoring").refactor("Extract Block To File")
        end,
        mode = "n",
        noremap = true,
        silent = true,
        expr = false,
        desc = "extract block to file",
      },
      {
        "<leader>ri",
        function()
          require("refactoring").refactor("Inline Variable")
        end,
        mode = "n",
        noremap = true,
        silent = true,
        expr = false,
        desc = "inline variable",
      },
    },
    config = true,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      default = {
        ["<leader>r"] = { name = "+refactor" },
      },
    },
  },
}
