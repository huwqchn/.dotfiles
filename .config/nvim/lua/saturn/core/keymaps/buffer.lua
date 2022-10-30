local M = {}

M.buffer = {
  name = "Buffer",
  o = { "<cmd>%bd|e#|bd#<CR>", "Close all but the current buffer" },
  x = { "<cmd>Bdelete!<CR>", "Close buffer" },
  n = { "<cmd>:bprevious<CR>", "Move Previous buffer" },
  i = { "<cmd>:bnext<CR>", "Move next buffer" },
  j = { "<cmd>BufferLinePick<CR>", "Jump" },
  f = { "<cmd>Telescope buffers<CR>", "Find buffer" },
  --b = { "<cmd>BufferLineCyclePrev<CR>", "Previous" },
  --n = { "<cmd>BufferLineCycleNext<CR>", "Next" },
  --w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
  c = {
    "<cmd>BufferLinePickClose<CR>",
    "Pick which buffer to close",
  },
  N = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
  I = {
    "<cmd>BufferLineCloseRight<cr>",
    "Close all to the right",
  },
  D = {
    "<cmd>BufferLineSortByDirectory<cr>",
    "Sort by directory",
  },
  L = {
    "<cmd>BufferLineSortByExtension<cr>",
    "Sort by language",
  },
}

function M.load()
  saturn.plugins.core.which_keys.mappings["b"] = buffer
end

return M
