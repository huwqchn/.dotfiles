-- lazy keymaps
vim.keymap.set("n", "<leader>pi", "<cmd>Lazy install<cr>", { desc = "Install" })
vim.keymap.set("n", "<leader>ps", "<cmd>Lazy sync<cr>", { desc = "Sync" })
vim.keymap.set("n", "<leader>pC", "<cmd>Lazy clear<cr>", { desc = "Status" })
vim.keymap.set("n", "<leader>pc", "<cmd>Lazy clean<cr>", { desc = "Clean" })
vim.keymap.set("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Update" })
vim.keymap.set("n", "<leader>pp", "<cmd>Lazy profile<cr>", { desc = "Profile" })
vim.keymap.set("n", "<leader>pl", "<cmd>Lazy log<cr>", { desc = "Log" })
vim.keymap.set("n", "<leader>pd", "<cmd>Lazy debug<cr>", { desc = "Debug" })

return {
  -- set to HEAD for now. I'm sill making too many changes for this repo related to lazy itself
  {
    "folke/lazy.nvim",
    version = false,
    init = function()
      saturn.plugins.whichkey.mappings.p = {
        name = "plugin",
      }
    end,
  },
}
