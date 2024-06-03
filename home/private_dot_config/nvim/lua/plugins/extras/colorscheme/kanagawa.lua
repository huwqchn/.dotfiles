return {
  -- kanigawa
  {
    "rebelot/kanagawa.nvim",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.fillchars:append({
        horiz = "━",
        horizup = "┻",
        horizdown = "┳",
        vert = "┃",
        vertleft = "┨",
        vertright = "┣",
        verthoriz = "╋",
      })
    end,
    opts = {
      globalStatus = true,
      transparent = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local colorscheme = "kanagawa"
        vim.g.colors_name = colorscheme
        vim.cmd.colorscheme(colorscheme)
      end,
    },
  },
}
