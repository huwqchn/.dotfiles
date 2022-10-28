local M = {}

local builtins = {
  "saturn.core.theme",
  "saturn.core.which-key",
  "saturn.core.gitsigns",
  "saturn.core.cmp",
  "saturn.core.dap",
  "saturn.core.terminal",
  "saturn.core.telescope",
  "saturn.core.treesitter",
  "saturn.core.nvimtree",
  "saturn.core.lir",
  "saturn.core.illuminate",
  "saturn.core.indentlines",
  "saturn.core.breadcrumbs",
  "saturn.core.project",
  "saturn.core.bufferline",
  "saturn.core.autopairs",
  "saturn.core.comment",
  "saturn.core.lualine",
  "saturn.core.alpha",
  "saturn.core.mason",
}

function M.config(config)
  for _, builtin_path in ipairs(builtins) do
    local builtin = reload(builtin_path)

    builtin.config(config)
  end
end

return M
