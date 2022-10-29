local M = {}

vim.cmd [[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]]

M.defaults = {
  {
    name = "BufferKill",
    fn = function()
      require("saturn.core.bufferline").buf_kill "bd"
    end,
  },
  {
    name = "SaturnToggleFormatOnSave",
    fn = function()
      require("saturn.core.autocmds").toggle_format_on_save()
    end,
  },
  {
    name = "SaturnInfo",
    fn = function()
      require("saturn.core.info").toggle_popup(vim.bo.filetype)
    end,
  },
  {
    name = "SaturnCacheReset",
    fn = function()
      require("saturn.utils.hooks").reset_cache()
    end,
  },
  {
    name = "SaturnReload",
    fn = function()
      require("saturn.config"):reload()
    end,
  },
  {
    name = "SaturnUpdate",
    fn = function()
      require("saturn.bootstrap"):update()
    end,
  },
  {
    name = "SaturnSyncCorePlugins",
    fn = function()
      require("saturn.plugin-loader").sync_core_plugins()
    end,
  },
  {
    name = "SaturnChangelog",
    fn = function()
      require("saturn.core.telescope.custom-finders").view_lunarvim_changelog()
    end,
  },
  {
    name = "SaturnOpenlog",
    fn = function()
      vim.fn.execute("edit " .. require("saturn.core.log").get_path())
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
