local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"
dashboard.section.header.val = require "saturn.basic.ui.logo"
dashboard.section.buttons.val = {
  dashboard.button("f", saturn.icons.ui.FindFile .. " Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", saturn.icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("p", saturn.icons.ui.Project .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
  dashboard.button("r", saturn.icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", saturn.icons.ui.FindText .. " Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", saturn.icons.ui.Gear .. " Configuration", ":e $MYVIMRC <CR>"),
  dashboard.button("q", saturn.icons.ui.Quit .. " Quit", ":qa<CR>"),
}
-- local function footer()
--   return "Stay foolish, Stay hungry"
-- end

local fortune = require('alpha.fortune')
dashboard.section.footer.val = fortune

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
