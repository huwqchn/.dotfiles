return {
  -- catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local colorscheme = "catppuccin"
        vim.g.colors_name = colorscheme
        vim.cmd.colorscheme(colorscheme)
      end,
    },
  },
}
