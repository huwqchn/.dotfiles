local M = {}
M.autocmd = require("util.autocmd")

--- lazy load lsp module by filetype
---@param filetype string|table
---@param setup fun()
function M.on_lsp_lazy(filetype, setup)
  M.autocmd.create_autocmds("FileType", {
    group = "_ON_LAZY_SETUP_LSP",
    pattern = filetype,
    callback = setup,
  })
end

function M.isempty(s)
  return s == nil or s == ""
end

-- toggle colorcolumn
M.toggle_colorcolumn = function()
  local value = vim.api.nvim_get_option_value("colorcolumn", {})
  if value == "" then
    vim.api.nvim_set_option_value("colorcolumn", "81", {})
  else
    vim.api.nvim_set_option_value("colorcolumn", "", {})
  end
end

-- find project root when git init
function M.find_project_root()
  local path = vim.fn.expand("%:p:h")
  while path and path ~= "/" do
    if vim.fn.isdirectory(path .. "/.git") == 1 then
      return path
    end
    path = vim.fn.fnamemodify(path, ":h")
  end
  return "."
end

return M
