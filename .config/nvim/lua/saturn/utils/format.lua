local M = {}
local loader = require("saturn.utils.loader")

local get_format_on_save_opts = function()
  local defaults = require("saturn.basic.settings").format_on_save
  -- accept a basic boolean `saturn.format_on_save=true`
  if type(saturn.format_on_save) ~= "table" then
    return defaults
  end

  return {
    pattern = saturn.format_on_save.pattern or defaults.pattern,
    timeout = saturn.format_on_save.timeout or defaults.timeout,
  }
end

function M.enable_format_on_save()
  local opts = get_format_on_save_opts()
  vim.api.nvim_create_augroup("lsp_format_on_save", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = "lsp_format_on_save",
    pattern = opts.pattern,
    callback = function()
      require("saturn.plugins.lsp.utils").format({ timeout_ms = opts.timeout, filter = opts.filter })
    end,
  })
end

function M.disable_format_on_save()
  loader.clear_augroup("lsp_format_on_save")
end

function M.configure_format_on_save()
  if type(saturn.format_on_save) == "table" and saturn.format_on_save.enabled then
    M.enable_format_on_save()
  elseif saturn.format_on_save == true then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

function M.toggle_format_on_save()
  local exists, autocmds = pcall(vim.api.nvim_get_autocmds, {
    group = "lsp_format_on_save",
    event = "BufWritePre",
  })
  if not exists or #autocmds == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

return M
