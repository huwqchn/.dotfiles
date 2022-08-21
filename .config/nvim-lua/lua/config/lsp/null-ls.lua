local status_ok, nls = pcall(require, "null-ls")
if not status_ok then
  return
end

local formatting = nls.builtins.formatting
local diagnostics = nls.builtins.diagnostics
local code_actions = nls.builtins.code_actions

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

nls.setup({
  sources = {
    formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
    diagnostics.eslint,
    formatting.prettier.with({
      extra_args = { "--single-quote", "false" },
    }),
    formatting.rustfmt,
    formatting.terraform_fmt,
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.goimports,
    formatting.gofumpt,
    -- formatting.flake8,
    formatting.shfmt,
    -- formatting.cppcheck,
    formatting.latexindent.with({
      extra_args = { "-g", "/dev/null" }, -- https://github.com/cmhughes/latexindent.pl/releases/tag/V3.9.3
    }),
    code_actions.shellcheck,
    code_actions.gitsigns,
    diagnostics.vale,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          if AUTOFORMAT_ACTIVE then -- global var defined in functions.lua
            vim.lsp.buf.format({ bufnr = bufnr })
          end
        end,
      })
    end
    require("core/functions").custom_lsp_attach(client, bufnr)
  end,
})
