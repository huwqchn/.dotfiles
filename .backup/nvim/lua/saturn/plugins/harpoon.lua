return {
  "christianchiarulli/harpoon",
  keys = {
    { "<leader>mn", '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" },
    { "<leader>mp", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" },
    { "<leader>ms", "<cmd>Telescope harpoon marks<cr>", "Search Files" },
    { "<leader>m;", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" },
    { "<leader>mm", '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },
    -- { "<leader>fm", "<cmd>Telescope harpoon marks<cr>", "Find harpoon mark files" },
  },
  enabled = saturn.enable_extra_plugins,
  config = true,
}
