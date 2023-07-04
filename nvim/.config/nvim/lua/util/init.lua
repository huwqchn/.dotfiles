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

--- do not create the keymap if a lazy keys handler exists
---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts table|nil
function M.lazy_keymap(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

function M.smart_quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_windows = vim.call("win_findbuf", bufnr)
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified and #buf_windows == 1 then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "y" then
        vim.cmd("q!")
      end
    end)
  else
    vim.cmd("q!")
  end
end

function M.popup_search()
  vim.ui.input({
    prompt = "Search: ",
  }, function(input)
    vim.cmd("noh")
    vim.cmd("silent! %s/" .. input .. "//gn")
  end)
end

function M.popup_cmd()
  vim.ui.input({
    prompt = "Command: ",
  }, function(input)
    vim.cmd(input)
  end)
end

function M.isempty(s)
  return s == nil or s == ""
end

function M.get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
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

return M
