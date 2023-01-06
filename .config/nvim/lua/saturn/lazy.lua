local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazy_path) then
  print("Installing first time setup")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazy_path,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazy_path)

local lazy_cache = require("lazy.core.cache")
lazy_cache.setup({
  performance = {
    cache = {
      enable = true,
    },
  },
})
-- HACK: Don't allow lazy to call setup second time
lazy_cache.setup = function() end

require("lazy").setup({
  spec = "saturn.plugins",
  defaults = { lazy = true, version = "*" },
  install = { missing = true, colorscheme = { saturn.colorscheme, "tokyonight", "habamax" } },
  ui = { border = "rounded" },
  git = { timeout = 120 },
  performance = {
    rtp = {
      reset = false,
      disabled_plugins = {
        -- "black",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "zipPlugin",
        "tohtml",
        "tutor",
        "gzip",
      },
    },
  },
})
