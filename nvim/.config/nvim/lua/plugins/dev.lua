return {
  {
    "huwqchn/postfix.nvim",
    lazy = false,
    dev = true,
    dir = "~/projects/postfix.nvim",
    config = function()
      require("postfix").setup()
    end,
  },
}
