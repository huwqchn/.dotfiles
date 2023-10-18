return {
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
        Robot = "󰚩 ",
        Package = " ",
        Smiley = " ",
        Magic = " ",
        CircuitBoard = " ",
        Otter = " ",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      diagnostics = {
        virtual_text = {
          prefix = " ",
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
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
}
