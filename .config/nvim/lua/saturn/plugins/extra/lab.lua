local M = {}

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
end

function M.setup()
  local present, lab = pcall(require, "lab")
  if not present then
    return
  end
  lab.setup(saturn.plugins.lab)

  -- lab keymaps
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_set_keymap
  keymap("n", "<m-4>", ":Lab code run<cr>", opts)
  keymap("n", "<m-5>", ":Lab code stop<cr>", opts)
  keymap("n", "<m-6>", ":Lab code panel<cr>", opts)

  if saturn.plugins.lab.on_config_done then
    saturn.plugins.lab.on_config_done(lab)
  end
end

return M
