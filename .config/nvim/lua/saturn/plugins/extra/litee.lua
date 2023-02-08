return {
  {
    "ldelossa/litee.nvim",
    opts = {
      tree = {
        icon_set = "codicons",
      },
      panel = {
        orientation = "right",
        panel_size = 30,
      },
      term = {
        position = "bottom",
        term_size = 15,
      },
    },
    config = function(_, opts)
      require("litee.lib").setup(opts)
    end,
  },
  { -- calltree
    "ldelossa/litee-calltree.nvim",
    keys = {
      { "<leader>ho", ":LTOpenToCalltree<cr>", desc = "Open To Calltree" },
      { "<leader>hO", ":LTPopOutCalltree<cr>", desc = "Open Out Calltree" },
      { "]c", ":LTNextCalltree<cr>", desc = "Next Calltree" },
      { "[c", ":LTPrevCalltree<cr>", desc = "Prev Calltree" },
      { "<leader>he", ":LTExpandCalltree<cr>", desc = "Expand Calltree" },
      { "<leader>hc", ":LTCollapseCalltree<cr>", desc = "Collapse Calltree" },
      { "<leader>hC", ":LTCollapseAllCalltree<cr>", desc = "Collapse All Calltree" },
      { "<leader>hf", ":LTFocusCalltree<cr>", desc = "Focus Calltree" },
      { "<leader>hS", ":LTSwitchCalltree<cr>", desc = "Switch Calltree" },
      { "<leader>hj", ":LTJumpCalltree<cr>", desc = "Jump Calltree" },
      { "<leader>hs", ":LTJumpCalltreeSplit<cr>", desc = "Jump Calltree Split" },
      { "<leader>hv", ":LTJumpCalltreeVSplit<cr>", desc = "Jump Calltree VSplit" },
      { "<leader>ht", ":LTJumpCalltreeTab<cr>", desc = "Jump Calltree Tab" },
      { "<leader>hh", ":LTHoverCalltree<cr>", desc = "Hover Calltree" },
      { "<leader>hH", ":LTHideCalltree<cr>", desc = "Hide Calltree" },
      { "<leader>hd", ":LTDetailsCalltree<cr>", desc = "Details Calltree" },
      { "<leader>hx", ":LTCloseCalltree<cr>", desc = "Close Calltree" },
    },
    dependencies = {
      "litee.nvim",
    },
    opts = {
      icon_set = "codicons",
      hide_cursor = false,
    },
    config = function(_, opts)
      require("litee.calltree").setup(opts)
    end,
  },
  { -- bookmarks
    "ldelossa/litee-bookmarks.nvim",
    keys = {
      { "<leader>mn", ":LTOpenNotebook<cr>", desc = "Open Notebook" },
      { "<leader>mo", ":LTOpenToNotebook<cr>", desc = "Open To Notebook" },
      { "<leader>mO", ":LTPopOutNotebook<cr>", desc = "Pop Out Notebook" },
      { "<leader>ml", ":LTListNotebooks<cr>", desc = "List Notebooks" },
      { "<leader>mc", ":LTCreateBookmark<cr>", desc = "Create Bookmark" },
      { "<leader>mh", ":LTHideBookmarks<cr>", desc = "Hide Bookmarks" },
    },
    dependencies = {
      "litee.nvim",
    },
    opts = {
      icon_set = "codicons",
    },
    config = function(_, opts)
      require("litee.bookmarks").setup(opts)
    end,
  },
}
