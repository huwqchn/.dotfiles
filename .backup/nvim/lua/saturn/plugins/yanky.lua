local M = {
  "gbprod/yanky.nvim",
  event = "BufReadPost",
  dependencies = {
    "kkharji/sqlite.lua",
    enabled = function()
      return not jit.os:find("Windows")
    end,
  },
  enabled = saturn.enable_extra_plugins,
}

function M.init()
  saturn.plugins.whichkey.mappings["y"] = {
    name = "Yanky",
    e = { "<Plug>(YankyCycleForward)", "Yanky Forward" },
    u = { "<Plug>(YankyCycleBackward)", "Yanky Backward" },
    y = {
      "<cmd>lua require('telescope').extensions.yank_history.yank_history({})<cr>",
      "Search Yanky",
    },
  }
end

function M.config()
  require("yanky").setup({
    highlight = {
      timer = 150,
    },
    ring = {
      storage = jit.os:find("Windows") and "shada" or "sqlite",
    },
  })

  vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

  vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
  vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
  vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
  vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

  -- vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
  -- vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

  -- vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
  -- vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
  -- vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
  -- vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")
  --
  -- vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
  -- vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
  -- vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
  -- vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

  vim.keymap.set("n", "]p", "<Plug>(YankyPutAfterFilter)")
  vim.keymap.set("n", "[p", "<Plug>(YankyPutBeforeFilter)")
end

return M
