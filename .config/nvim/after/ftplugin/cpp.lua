vim.opt_local.textwidth = 100
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.commentstring = "//  %s"
vim.opt_local.cindent = true
vim.opt_local.cinoptions:append("g0,N-s,E-s,l1,:0")
vim.wo.wrap = false

require("saturn.plugins.lsp.null-ls.formatters").setup({
  { command = "clang-format", filetype = { "cpp" } },
})

require("saturn.plugins.lsp.manager").setup("clangd", {
  on_attach = function(client, bufnr)
    vim.keymap.set(
      "n",
      "<leader><space>",
      "<cmd>ClangdSwitchSourceHeader<cr>",
      { desc = "switch between header and source" }
    )
    require("saturn.plugins.lsp.hooks").common_on_attach(client, bufnr)
  end,
})

-- saturn.plugins.dap.on_config_done = function(dap)
--   dap.adapters.lldb = {
--     type = "executable",
--     command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
--     name = "lldb",
--   }
--   dap.configureations.cpp = {
--     {
--       name = "Launch",
--       type = "lldb",
--       request = "launch",
--       program = function()
--         return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--       end,
--       cwd = "${workspaceFolder}",
--       stopOnEntry = false,
--       args = {},
--     },
--   }
--   local api = vim.api
--   local keymap_restore = {}
--   dap.listeners.after["event_initialized"]["me"] = function()
--     for _, buf in pairs(api.nvim_list_bufs()) do
--       local keymaps = api.nvim_buf_get_keymap(buf, "n")
--       for _, keymap in pairs(keymaps) do
--         if keymap.lhs == "H" then
--           table.insert(keymap_restore, keymap)
--           api.nvim_buf_del_keymap(buf, "n", "H")
--         end
--       end
--     end
--     api.nvim_set_keymap("n", "H", '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
--   end

--   dap.listeners.after["event_terminated"]["me"] = function()
--     for _, keymap in pairs(keymap_restore) do
--       api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, { silent = keymap.silent == 1 })
--     end
--     keymap_restore = {}
--   end
-- end
