local M = {}

M.quickfix = {
  name = "Quickfix",
  i = { "<cmd>cnext<cr>", "Next Quickfix Item" },
  n = { "<cmd>cprevious<cr>", "Previous Quickfix Item" },
  q = { "<cmd>lua require('functions').toggle_qf()<cr>", "Toggle quickfix list" },
  t = { "<cmd>TodoQuickFix<cr>", "Show TODOs" },
}

function M.load()
  saturn.plugins.core.which_key.mappings['q'] = M.quickfix
end

return M
