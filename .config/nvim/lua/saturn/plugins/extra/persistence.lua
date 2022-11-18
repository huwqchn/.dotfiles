local M = {}

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
  if saturn.plugins.persistence.active then
    saturn.plugins.whichkey.mappings["S"] = {
      name = "Session",
      c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
      l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
      Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
    }
  end
end

M.setup = function()
  local present, persistence = pcall(require, "persistence")
  if not present then
    return
  end
  persistence.setup(saturn.plugins.persistence)
  if saturn.plugins.persistence.on_config_done then
    saturn.plugins.persistence.on_config_done(persistence)
  end
end

return M
