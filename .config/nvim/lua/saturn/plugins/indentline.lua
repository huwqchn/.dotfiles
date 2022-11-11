local M = {}

function M.config()
  saturn.plugins.indentlines = {
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

function M.setup()
  local present, indent_blankline = pcall(require, "indent_blankline")
  if not present then
    return
  end

  indent_blankline.setup(saturn.plugins.indentlines.options)

  if saturn.plugins.indentlines.on_config_done then
    saturn.plugins.indentlines.on_config_done()
  end
end

return M
