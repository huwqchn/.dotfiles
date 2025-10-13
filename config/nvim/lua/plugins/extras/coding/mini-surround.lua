-- default surround
return {
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  {
    "nvim-mini/mini.surround",
    optional = true,
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sl", -- Update `n_lines`
      },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "s", group = "surround/select/split" },
        },
      },
    },
  },
}
