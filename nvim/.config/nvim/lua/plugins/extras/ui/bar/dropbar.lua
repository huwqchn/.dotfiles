return {
  {
    "SmiteshP/nvim-navic",
    enabled = false,
  },
  {
    "Bekaboo/dropbar.nvim",
    keys = {
      {
        "sp",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Select dropbar",
      },
    },
    opts = true,
    event = "VeryLazy",
  },
}
