return {
  {
    "tomasky/bookmarks.nvim",
    keys = {
      { "m", mode = "n" },
      { "mm", mode = "n", desc = "Toggle bookmark" },
      { "mc", mode = "n", desc = "Clear bookmarks" },
      { "ma", mode = "n", desc = "Add or edit bookmarks" },
      { "ml", mode = "n", desc = "List bookmarks" },
      { "]m", mode = "n", desc = "Next bookmark" },
      { "[m", mode = "n", desc = "Previous bookmark" },
    },
    opts = {
      save_file = vim.fn.expand("$HOME/.local/share/nvim/.bookmarks"), -- bookmarks save file path
      keywords = {
        ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
        ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
        ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
        ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
      },
      on_attach = function(bufnr)
        local bm = require("bookmarks")
        local map = vim.keymap.set
        map("n", "mm", bm.bookmark_toggle) -- add or remove bookmark at current line
        map("n", "ma", bm.bookmark_ann) -- add or edit mark annotation at current line
        map("n", "mc", bm.bookmark_clean) -- clean all marks in local buffer
        map("n", "]m", bm.bookmark_next) -- jump to next mark in local buffer
        map("n", "[m", bm.bookmark_prev) -- jump to previous mark in local buffer
        map("n", "ml", bm.bookmark_list) -- show marked file list in quickfix window
      end,
    },
  },
}
