return {
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
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = require("lazyvim.config").icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = require("lazyvim.config").icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = require("lazyvim.config").icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = require("lazyvim.config").icons.diagnostics.Info,
          },
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
