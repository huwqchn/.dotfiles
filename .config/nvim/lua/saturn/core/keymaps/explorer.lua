local M = {}

M.explorer = {
  name = "Explorer",
  e = { "<cmd>NvimTreeToggle<CR>", "Project" }
  c = { "<cmd>NvimTreeCollapse<CR>", "Collapse" }
  s = { "<cmd>SymbolsOutline<CR>", "SymbolsOutline" }
}

function M.load()
  saturn.plugins.core.which_key.mappings['e'] = M.explorer
end

return M
