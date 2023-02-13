vim.o.wrap = true

saturn.plugins.which_key.mappings["<leader>n"] = { name = "+note" }

vim.keymap.set("n", "<leader><space>", function()
  local peek = require("peek")
  if peek.is_open() then
    peek.close()
  else
    peek.open()
  end
end, { desc = "Peek (Markdown Preview)" })

-- Add the key mappings only for Markdown files in a zk notebook.
if require("zk.util").notebook_root(vim.fn.expand("%:p")) ~= nil then
  local function map(...)
    vim.api.nvim_buf_set_keymap(0, ...)
  end
  opts = { noremap = true, silent = false }

  -- Open the link under the caret.
  map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- Preview a linked note.
  map("n", "H", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- Create a new note after asking for its title.
  -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
  map("n", "<leader>nn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for title.
  map("v", "<leader>nt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
  map(
    "v",
    "<leader>nc",
    ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
    opts
  )

  -- Open notes linking to the current buffer.
  map("n", "<leader>nb", "<Cmd>ZkBacklinks<CR>", opts)
  -- Alternative for backlinks using pure LSP and showing the source context.
  --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- Open notes linked by the current buffer.
  map("n", "<leader>nl", "<Cmd>ZkLinks<CR>", opts)
  -- Open the code actions for a visual selection.
  map("v", "<leader>na", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
end
