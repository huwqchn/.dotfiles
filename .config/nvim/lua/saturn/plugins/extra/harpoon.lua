local M = {}

M.config = function()
  saturn.plugins.harpoon = {
    active = true,
    on_config_done = nil,
  }
  saturn.plugins.whichkey.mappings["m"]["n"] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" }
  saturn.plugins.whichkey.mappings["m"]["p"] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" }
  saturn.plugins.whichkey.mappings["m"]["s"] = { "<cmd>Telescope harpoon marks<cr>", "Search Files" }
  saturn.plugins.whichkey.mappings["m"][";"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" }
  saturn.plugins.whichkey.mappings["m"]["m"] = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" }
end

M.setup = function()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end

  local h_status_ok, harpoon = pcall(require, "harpoon")
  if not h_status_ok then
    return
  end
  telescope.load_extension("harpoon")
  harpoon.setup(saturn.plugins.harpoon)

  if saturn.plugins.on_config_done then
    saturn.plugins.on_config_done(harpoon)
  end
end

return M
