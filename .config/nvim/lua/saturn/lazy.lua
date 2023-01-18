local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = "saturn.plugins",
  defaults = { lazy = true, version = "*" },
  install = { colorscheme = { "tokyonight-night", "habamax" } },
  ui = { border = "rounded" },
  git = {
    timeout = 120,
  },
  checker = { enabled = true },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

vim.keymap.set("n", "<leader>pi", "<cmd>Lazy install<cr>", { desc = "Install" })
vim.keymap.set("n", "<leader>ps", "<cmd>Lazy sync<cr>", { desc = "Sync" })
vim.keymap.set("n", "<leader>pC", "<cmd>Lazy clear<cr>", { desc = "Status" })
vim.keymap.set("n", "<leader>pc", "<cmd>Lazy clean<cr>", { desc = "Clean" })
vim.keymap.set("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Update" })
vim.keymap.set("n", "<leader>pp", "<cmd>Lazy profile<cr>", { desc = "Profile" })
vim.keymap.set("n", "<leader>pl", "<cmd>Lazy log<cr>", { desc = "Log" })
vim.keymap.set("n", "<leader>pd", "<cmd>Lazy debug<cr>", { desc = "Debug" })
