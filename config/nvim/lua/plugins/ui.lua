return {
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      scope = {
        enabled = false,
      },
      zen = {
        toggles = {
          dim = false,
          git_signs = false,
          mini_diff_signs = false,
        },
        win = {
          backdrop = { transparent = false, blend = 99 },
          wo = {
            number = false,
            relativenumber = false,
            colorcolumn = "",
            signcolumn = "no",
            statuscolumn = "",
            winbar = "",
            cursorline = false,
          },
        },
        on_open = function()
          -- disable snacks indent
          Snacks.indent.disable()
          vim.cmd("GitBlameDisable")
        end,
        on_close = function()
          -- restore snacks indent setting
          Snacks.indent.enable()
          vim.cmd("GitBlameEnable")
        end,
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    cond = not vim.g.started_by_firenvim,
    dependencies = {
      {
        "tiagovla/scope.nvim",
        config = true,
      },
    },
    keys = {
      -- { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next" },
      -- { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous" },
      { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Jump" },
      { "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Pick Close" },
      { "<leader>b[", "<cmd>BufferLineMoveLeft<cr>", desc = "Move left" },
      { "<leader>b]", "<cmd>BufferLineMoveRight<cr>", desc = "Move right" },
      { "<leader>b{", "<cmd>BufferLineCloseLeft<cr>", desc = "Close all to the left" },
      { "<leader>b}", "<cmd>BufferLineCloseRight<cr>", desc = "Close all to the right" },
      { "<leader>bD", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort by directory" },
      { "<leader>bL", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort by language" },
    },
    opts = {
      highlights = {
        background = {
          italic = true,
        },
        buffer_selected = {
          bold = true,
        },
      },
      options = {
        indicator = {
          style = "underline", -- can also be 'underline'|'none',
        },
        name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
          -- remove extension from markdown files for example
          if buf.name:match("%.md") then
            return vim.fn.fnamemodify(buf.name, ":t:r")
          end
        end,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
      },
    },
  },
}
