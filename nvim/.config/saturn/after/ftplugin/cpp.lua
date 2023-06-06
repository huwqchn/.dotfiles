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

-- pcall(function()
--   require("clangd_extensions").setup({
--     server = {
--       on_attach = function(client, bufnr)
--         require("saturn.plugins.lsp.hooks").common_on_attach(client, bufnr)
--         vim.keymap.set(
--           "n",
--           "<leader><space>",
--           "<cmd>ClangdSwitchSourceHeader<cr>",
--           { desc = "switch between header and source" }
--         )
--         vim.keymap.set("n", "<leader>nt", "<cmd>ClangdSymbolInfo<cr>", { desc = "Type hierarchy" })
--       end,
--     },
--     extensions = {
--       -- defaults:
--       -- Automatically set inlay hints (type hints)
--       autoSetHints = false,
--       -- These apply to the default ClangdSetInlayHints command
--       ast = {
--         role_icons = {
--           type = "",
--           declaration = "",
--           expression = "",
--           specifier = "",
--           statement = "",
--           ["template argument"] = "",
--         },
--         kind_icons = {
--           Compound = "",
--           Recovery = "",
--           TranslationUnit = "",
--           PackExpansion = "",
--           TemplateTypeParm = "",
--           TemplateTemplateParm = "",
--           TemplateParamObject = "",
--         },
--         highlights = {
--           detail = "Comment",
--         },
--       },
--       memory_usage = {
--         border = "rounded",
--       },
--       symbol_info = {
--         border = "rounded",
--       },
--     },
--   })
-- end)
saturn.plugins.dap.on_config_done = require("saturn.utils.dap").cppdbg_config
saturn.plugins.which_key.mappings["<leader>n"] = { name = "+cpp" }
