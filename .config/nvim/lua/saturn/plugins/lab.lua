local M = {
  "0x100101/lab.nvim",
  build = "cd js && npm ci",
  cmd = "Lab",
  enabled = saturn.enable_extra_plugins,
  keys = {
    { "<m-s-4>", ":Lab code run<cr>" },
    { "<m-s-5>", ":Lab code stop<cr>" },
    { "<m-s-6>", ":Lab code panel<cr>" },
  },
}

function M.config()
  require("lab").setup({
    active = true,
    on_config_done = nil,
    code_runner = {
      enabled = true,
    },
    quick_data = {
      enabled = false,
    },
  })
end

return M
