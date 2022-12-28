local M = {}

M.config = function()
  saturn.plugins.zk = {
    active = true,
    on_config_done = nil,

    picker = "telescope",

    lsp = {
      -- `config` is passed to `vim.lsp.start_client(config)`
      config = {
        cmd = { "zk", "lsp" },
        name = "zk",
        -- on_attach = ...
        -- etc, see `:h vim.lsp.start_client()`
      },

      -- automatically attach buffers in a zk notebook that match the given filetypes
      auto_attach = {
        enabled = true,
        filetypes = { "markdown" },
      },
    },
  }
end

M.setup = function()
  local status_ok, zk = pcall(require, "zk")
  if not status_ok then
    return
  end
  zk.setup(saturn.plugins.zk)
  if saturn.plugins.zk.on_config_done then
    saturn.plugins.zk.on_config_done(zk)
  end
end

return M
