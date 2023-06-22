local M = {}
local colorscheme = os.getenv("THEME")
if colorscheme == nil then
  colorscheme = "catppuccin"
end
local theme_path = "plugins.extras.ui.theme." .. colorscheme
local has_theme, _ = pcall(require, theme_path)
if has_theme then
  M = {
    { import = theme_path },
    -- Configure LazyVim to load color scheme
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = function()
          vim.g.colors_name = colorscheme
          vim.cmd.colorscheme(colorscheme)
        end,
      },
    },
  }
end

return M
