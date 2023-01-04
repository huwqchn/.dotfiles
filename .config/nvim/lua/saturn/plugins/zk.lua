local M = {
  "mickael-menu/zk-nvim",
  enabled = saturn.enable_extra_plugins,
  ft = "markdown",
}

M.config = function()
  saturn.plugins.zk = {
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

  require("zk").setup(saturn.plugins.zk)
end

return M
