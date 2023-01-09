local M = {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  enabled = saturn.enable_extra_plugins,
}

M.init = function()
  saturn.plugins.whichkey.mappings["S"] = {
    name = "Session",
    s = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
    l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
    q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
  }
end

M.config = function()
  saturn.plugins.persistence = {
    active = true,
    on_config_done = nil,
    dir = vim.fn.stdpath("data") .. "/sessions/",
    options = {
      "buffers",
      "curdir",
      "tabpages",
      "winsize",
    },
  }
  require("persistence").setup(saturn.plugins.persistence)
end

return M
