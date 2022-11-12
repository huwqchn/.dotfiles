local M = {}

function M.config()
  saturn.plugins.dial = {
    active = true,
    on_config_done = nil,
  }
end

function M.setup()
  if not saturn.plugins.dial.active then
    return
  end

  local status_ok, dial_config = pcall(require, "dial.config")
  if not status_ok then
    return
  end

  local augend = require "dial.augend"

  dial_config.augends:register_group {
    default = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.date.alias["%Y/%m/%d"],
    },
    typescript = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.constant.new { elements = { "let", "const" } },
    },
    visual = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.date.alias["%Y/%m/%d"],
      augend.constant.alias.alpha,
      augend.constant.alias.Alpha,
    },
    mygroup = {
      augend.constant.new {
        elements = { "and", "or" },
        word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
        cyclic = true, -- "or" is incremented into "and".
      },
      augend.constant.new {
        elements = { "True", "False" },
        word = true,
        cyclic = true,
      },
      augend.constant.new {
        elements = { "public", "private" },
        word = true,
        cyclic = true,
      },
      augend.constant.new {
        elements = { "&&", "||" },
        word = false,
        cyclic = true,
      },
      augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
      augend.constant.alias.bool, -- boolean value (true <-> false)
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.semver.alias.semver
    },
  }

  local map = require "dial.map"

  -- change augends in VISUAL mode
  vim.api.nvim_set_keymap("n", "<leader>=", map.inc_normal "mygroup", { noremap = true })
  vim.api.nvim_set_keymap("n", "<leader>-", map.dec_normal "mygroup", { noremap = true })
  vim.api.nvim_set_keymap("v", "<leader>=", map.inc_normal "visual", { noremap = true })
  vim.api.nvim_set_keymap("v", "<leader>-", map.dec_normal "visual", { noremap = true })

  vim.cmd [[
    " enable only for specific FileType
    autocmd FileType typescript,javascript lua vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", require("dial.map").inc_normal("typescript"), {noremap = true})
  ]]
end

return M
