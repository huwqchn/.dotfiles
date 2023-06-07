return {
  {
    "folke/neodev.nvim",
    opts = {
      library = {
        plugins = { "neotest" },
        types = true,
      },
      experimental = {
        pathStrict = true,
      },
    },
  },
}
