return {
  {
    "potamides/pantran.nvim",
    keys = {
      {
        "<leader>lr",
        function()
          require("pantran").motion_translate()
        end,
        desc = "Translate",
      },
      {
        "<leader>lR",
        function()
          return require("pantran").motion_translate() .. "_"
        end,
        desc = "Translate and replace",
      },
      {
        "<leader>lr",
        function()
          require("pantran").motion_translate()
        end,
        mode = "v",
        desc = "Translate",
      },
    },
    opts = {
      controls = {
        mappings = {
          edit = {
            n = {
              -- Use this table to add additional mappings for the normal mode in
              -- the translation window. Either strings or function references are
              -- supported.
              ["e"] = "gj",
              ["i"] = "gk",
            },
            i = {
              -- Similar table but for insert mode. Using 'false' disables
              -- existing keybindings.
              ["<C-y>"] = false,
              ["<C-a>"] = require("pantran.ui.actions").yank_close_translation,
            },
          },
          -- Keybindings here are used in the selection window.
          select = {
            n = {
              ["e"] = "gj",
              ["i"] = "gk",
            },
          },
        },
      },
    },
  },
}
