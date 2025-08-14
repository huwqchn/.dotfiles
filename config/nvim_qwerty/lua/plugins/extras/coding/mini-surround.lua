-- default surround
return {
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
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
