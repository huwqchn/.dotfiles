local NS = { noremap = true, silent = true }

vim.keymap.set('x', 'aa', function() require'align'.align_to_char(1, true)             end, NS) -- Aligns to 1 character, looking left
vim.keymap.set('x', 'as', function() require'align'.align_to_char(2, true, true)       end, NS) -- Aligns to 2 characters, looking left and with previews
vim.keymap.set('x', 'aw', function() require'align'.align_to_string(false, true, true) end, NS) -- Aligns to a string, looking left and with previews
vim.keymap.set('x', 'ar', function() require'align'.align_to_string(true, true, true)  end, NS) -- Aligns to a Lua pattern, looking left and with previews

-- Example gawip to align a paragraph to a string, looking left and with previews
vim.keymap.set(
  'n',
  '<leader>aw',
  function()
      local a = require'align'
      a.operator(
          a.align_to_string,
          { is_pattern = false, reverse = true, preview = true }
      )
  end,
  NS
)

-- Example gaaip to aling a paragraph to 1 character, looking left
vim.keymap.set(
  'n',
  '<leader>aa',
  function()
      local a = require'align'
      a.operator(
          a.align_to_char,
          { reverse = true }
      )
  end,
  NS
)
