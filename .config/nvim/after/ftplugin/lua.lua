require("saturn.plugins.lsp.manager").setup("sumneko_lua")
require("saturn.plugins.lsp.null-ls.formatters").setup({
  { command = "stylua", args = { "lua" } },
})

saturn.plugins.dap.on_config_done = function(dap)
  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
    },
  }
  dap.adapters.nlua = function(callback, config)
    callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
  end

  vim.keymap.set("n", "<leader>ds", function()
    require("osv").launch({ port = 8086 })
  end, { desc = "Launch Lua Debugger Server" })

  vim.keymap.set("n", "<leader>dd", function()
    require("osv").run_this()
  end, { desc = "Launch Lua Debugger" })
end
