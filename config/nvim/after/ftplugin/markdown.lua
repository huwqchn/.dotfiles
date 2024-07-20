vim.o.colorcolumn = ""
vim.o.wrap = true

vim.keymap.set("n", "<leader>p", function()
  local peek = require("peek")
  if peek.is_open() then
    peek.close()
  else
    peek.open()
  end
end, { desc = "Peek (Markdown Preview)" })
