local M = {}

M.tab = {
  name = "Tab",
  t = { "<cmd>:tabnew<CR>", "New tab" },
  s = { "<cmd>:tab split<CR>", "New and move the tab" },
  x = { "<cmd>:tabclose<CR>", "Close tab" },
  n = { "<cmd>:tabn<CR>", "Go to next tab" },
  i = { "<cmd>:tabp<CR>", "Go to previous tab" },
  N = { "<cmd>:-tabmove<CR>", "Move the tab to left" },
  I = { "<cmd>:+tabmove<CR>", "Move the tab to right" },
  o = { "<cmd>:tabonly<CR>", "Close all other tabs" },
  a = { "<cmd>:tabfirst<CR>", "Go to first tab" },
  z = { "<cmd>:tablast<CR>", "Go to last tab" },
  A = { "<cmd>:tabm 0<CR>", "Move to first tab" },
  Z = { "<cmd>:tabm<CR>", "Move to last tab" },
  l = { "<cmd>:tabs<CR>", "List all tabs" },
}

function M.load()
  saturn.plugins.core.which_key.mappings["t"] = M.tab
end

return M
