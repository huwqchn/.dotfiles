local M = {}

M.terminal = {
  name = "terminal",
  p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
  f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
  h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
  v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
}

function M.load()
  saturn.plugins.core.which_key.mappings["x"] = M.console
end

return M
