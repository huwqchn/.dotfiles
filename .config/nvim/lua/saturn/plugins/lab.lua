local M = {
  "0x100101/lab.nvim",
  build = "cd js && npm ci",
  cmd = "Lab",
  enabled = saturn.enable_extra_plugins,
}

function M.init()
  -- lab keymaps
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_set_keymap
  keymap("n", "<m-s-4>", ":Lab code run<cr>", opts)
  keymap("n", "<m-s-5>", ":Lab code stop<cr>", opts)
  keymap("n", "<m-s-6>", ":Lab code panel<cr>", opts)
end

function M.config()
  saturn.plugins.lab = {
    active = true,
    on_config_done = nil,
    code_runner = {
      enabled = true,
    },
    quick_data = {
      enabled = false,
    },
  }
  require("lab").setup(saturn.plugins.lab)
end

return M
