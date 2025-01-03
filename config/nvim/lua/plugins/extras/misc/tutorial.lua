return {
  {
    "m4xshen/hardtime.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    opts = {},
  },
  {
    "tris203/precognition.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },
  {
    "meznaric/key-analyzer.nvim",
    lazy = true,
    opts = {},
    cmd = { "KeyAnalyzer" },
  },
}
