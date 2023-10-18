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
}
