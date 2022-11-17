local fineline = require("fine-cmdline")
local fn = fineline.fn
fineline.setup({
  cmdline = {
    -- Prompt can influence the completion engine.
    -- Change it to something that works for you
    prompt = ": ",
    -- smart_history = true,

    -- Let the user handle the keybindings
    enable_keymaps = false,
  },
  popup = {
    position = {
      row = "10%",
      col = "50%",
    },
    size = {
      width = "60%",
    },
    border = {
      style = "rounded",
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
  },
  hooks = {
    set_keymaps = function(imap, feedkeys)
      -- Restore default keybindings...
      -- Except for `<Tab>`, that's what everyone uses to autocomplete
      imap("<Esc>", fn.close)
      imap("<C-c>", fn.close)

      imap("<C-u>", fn.up_search_history)
      imap("<C-e>", fn.down_search_history)
      imap("<C-n>", fn.complete_or_next_item)
      imap("<C-p>", fn.stop_complete_or_previous_item)
    end,
  },
})

vim.api.nvim_set_keymap("n", "<cr>", "<cmd>FineCmdline<CR>", { noremap = true })
