return {
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = {
      icons = {
        Saturn = "",
        SeparatorRight = "",
        SeparatorLeft = "",
        GitBranch = "",
        GitLineAdded = "",
        GitLineModified = "",
        GitLineRemoved = "",
        LspPrefix = " ",
        DiagError = "",
        DiagWarning = "",
        DiagInformation = "",
        DiagHint = "",
        Keyboard = "",
        Bug = "",
      },
    },
  },
  {
    "SmiteshP/nvim-navic",
    optional = true,
    opts = function(_, opts)
      opts.separator = " " .. ">" .. " "
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = {
      icons = {
        Copilot = " ",
        Robot = "ﮧ",
        Package = "",
        Smiley = "",
        Magic = " ",
        CircuitBoard = "",
      },
    },
  },
}
