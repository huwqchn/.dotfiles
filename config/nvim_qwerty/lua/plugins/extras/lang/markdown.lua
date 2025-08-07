return {
  { import = "lazyvim.plugins.extras.lang.markdown" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "vimwiki", "norg", "rmd", "org" },
    opts = function()
      return {
        file_types = { "markdown", "norg", "rmd", "org" },
      }
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      image = {},
    },
  },
}
