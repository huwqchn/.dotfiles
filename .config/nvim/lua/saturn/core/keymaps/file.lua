local M = {}

local M.file = {
  name = "Files",
  f = { "<cmd>Telescope find_files<CR>", "Find File" },
  a = { "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", "find all" },
  o = { "<cmd>Telescope file_browser<CR>", "File browser" },
  g = { "<cmd>Telescope live_grep<CR>", "live grep" },
  l = { "<cmd>Lf<CR>", "Open LF" },
  r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
  z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
  h = { "<cmd>Telescope help_tags<CR>", "help page" },
  b = { "<cmd>Telescope buffers<CR>", "find buffers" },
}

function M.load()
  saturn.plugins.core.whick_key.mappings['f'] = M.file
end

return M
