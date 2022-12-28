saturn.plugins.whichkey.mappings["S"] = {
  name = "Session",
  s = { "<cmd>SaveSession<cr>", "Save" },
  r = { "<cmd>RestoreSession<cr>", "Restore" },
  x = { "<cmd>DeleteSession<cr>", "Delete" },
  f = { "<cmd>Autosession search<cr>", "Find" },
  d = { "<cmd>Autosession delete<cr>", "Find Delete" },
}
saturn.plugins.whichkey.mappings["c"] = {
  name = "Code documentation",
  c = { ":lua require('neogen').generate()<CR>", "Generate documentation" }
}

