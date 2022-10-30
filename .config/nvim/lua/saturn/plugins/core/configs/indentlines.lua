local M = {}

M.config = function()
  saturn.plugins.core.indentlines = {
    active = true,
    on_config_done = nil,
    options = {
      enabled = true,
      buftype_exclude = { "terminal", "nofile" },
      filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "text",
      },
      char = saturn.icons.ui.LineLeft,
      show_trailing_blankline_indent = false,
      show_first_indent_level = true,
      use_treesitter = true,
      show_current_context = true,
    },
  }
end

M.setup = function()
  local status_ok, indent_blankline = pcall(reload, "indent_blankline")
  if not status_ok then
    return
  end

  indent_blankline.setup(saturn.plugins.core.indentlines.options)

  if saturn.plugins.core.indentlines.on_config_done then
    saturn.plugins.core.indentlines.on_config_done()
  end
end

return M
