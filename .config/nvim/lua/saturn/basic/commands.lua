local M = {}

vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]])

M.default = {
  {
    name = "BufferKill",
    fn = function()
      require("saturn.plugins.core.bufferline").buf_kill("bd")
    end,
  },
  {
    name = "ToggleFormatOnSave",
    fn = function()
      require("saturn.basic.autocmds").toggle_format_on_save()
    end,
  },
  {
    name = "CacheReset",
    fn = function()
      require("saturn.utils.hooks").reset_cache()
    end,
  },
  {
    name = "SyncCorePlugins",
    fn = function()
      require("saturn.plugins.plugin_loader").sync_core_plugins()
    end,
  },
  {
    name = "OpenLog",
    fn = function()
      vim.fn.execute("edit " .. require("saturn.plugins.core.log").get_path())
    end,
  },
}

function M.load(collection)
  local common_opts = { force = true }
  for _, cmd in pairs(collection) do
    local opts = vim.tbl_deep_extend("force", common_opts, cmd.opts or {})
    vim.api.nvim_create_user_command(cmd.name, cmd.fn, opts)
  end
end

return M
