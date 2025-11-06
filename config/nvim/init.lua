local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" }) -- last stable release
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- import LazyVim plugins
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        news = {
          lazyvim = true,
          neovim = true,
        },
      },
    },
    -- my plugins
    { import = "plugins" },
  },
  change_detection = { notify = false },
  defaults = { lazy = true, version = false },
  install = { colorscheme = { "tokyonight", "habamax" } },
  ui = { border = "rounded" },
  git = {
    timeout = 120,
  },
  checker = { enabled = false },
  diff = {
    cmd = "terminal_git",
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
