local M = {
  "christianchiarulli/harpoon",
  enabled = saturn.enable_extra_plugins,
}

M.init = function()
  saturn.plugins.harpoon = {
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = true,

    -- saves the harpoon file upon every change. disabling is unrecommended.
    save_on_change = true,

    -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    enter_on_sendcmd = false,

    -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
    tmux_autoclose_windows = false,

    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = { "harpoon" },

    -- set marks specific to each git branch inside git repository
    mark_branch = false,
  }
  saturn.plugins.whichkey.mappings["m"]["n"] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" }
  saturn.plugins.whichkey.mappings["m"]["p"] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" }
  saturn.plugins.whichkey.mappings["m"]["s"] = { "<cmd>Telescope harpoon marks<cr>", "Search Files" }
  saturn.plugins.whichkey.mappings["m"][";"] =
    { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" }
  saturn.plugins.whichkey.mappings["m"]["m"] = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" }
  saturn.plugins.whichkey.mappings["f"]["m"] = { "<cmd>Telescope harpoon marks<cr>", "Find harpoon mark files" }
end

M.config = function()
  require("telescope").load_extension("harpoon")
  require("harpoon").setup(saturn.plugins.harpoon)
end

return M
