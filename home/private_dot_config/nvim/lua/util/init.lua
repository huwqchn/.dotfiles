local M = {}
M.autocmd = require("util.autocmd")
M.lualine = require("util.lualine")

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

-- cowboy
function M.cowboy(mode, key, map, opts)
  local id
  local ok = true
  local count = 0
  local timer = assert(vim.uv.new_timer())
  vim.keymap.set(mode, key, function()
    if vim.v.count > 0 then
      count = 0
    end
    if count >= 10 and vim.bo.buftype ~= "nofile" then
      ok, id = pcall(vim.notify, "Hold it Cowboy!", vim.log.levels.WARN, {
        icon = "🤠",
        replace = id,
        keep = function()
          return count >= 10
        end,
      })
      if not ok then
        id = nil
        return map
      end
    else
      count = count + 1
      timer:start(2000, 0, function()
        count = 0
      end)
      return map
    end
  end, opts)
end

return M
