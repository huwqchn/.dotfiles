local M = {}

local banner = require 'saturn.core.ui.logo'

if vim.o.lines < 36 then
  banner = vim.list_slice(banner, 16, 22)
end

function M.get_sections()
  local header = {
    type = "text",
    val = banner,
    opts = {
      position = "center",
      hl = "Label",
    },
  }


  local footer = {
    type = "text",
    val = "Stay foolish, Stay hungry"
  }
  local buttons = {}

  local status_ok, dashboard = pcall(require, "alpha.themes.dashboard")
  if status_ok then
    local function button(sc, txt, keybind, keybind_opts)
      local b = dashboard.button(sc, txt, keybind, keybind_opts)
      b.opts.hl_shortcut = "Macro"
      return b
    end
    buttons = {
      val = {
        button("f", saturn.icons.ui.FindFile .. "  Find File", "<CMD>Telescope find_files<CR>"),
        button("n", saturn.icons.ui.NewFile .. "  New File", "<CMD>ene!<CR>"),
        button("p", saturn.icons.ui.Project .. "  Projects ", "<CMD>Telescope projects<CR>"),
        button("r", saturn.icons.ui.History .. "  Recent files", ":Telescope oldfiles <CR>"),
        button("t", saturn.icons.ui.FindText .. "  Find Text", "<CMD>Telescope live_grep<CR>"),
        button(
          "c",
          saturn.icons.ui.Gear .. "  Configuration",
          "<CMD>edit " .. "~/.config/nvim" .. " <CR>"
        ),
      },
    }
  end

  return {
    header = header,
    buttons = buttons,
    footer = footer,
  }
end

return M
