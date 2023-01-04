local M = {
  "monaqa/dial.nvim",
  enabled = saturn.enable_extra_plugins,
  keys = {
    -- change augends in VISUAL mode
    { "n", "<C-=>", require("dial.map").inc_normal("mygroup"), { noremap = true } },
    { "n", "<C-->", require("dial.map").dec_normal("mygroup"), { noremap = true } },
    { "v", "<C-=>", require("dial.map").inc_normal("visual"), { noremap = true } },
    { "v", "<C-->", require("dial.map").dec_normal("visual"), { noremap = true } },
  },
}

function M.config()
  local dial_config = require("dial.config")

  local augend = require("dial.augend")

  dial_config.augends:register_group({
    default = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.date.alias["%Y/%m/%d"],
    },
    typescript = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.constant.new({ elements = { "let", "const" } }),
    },
    visual = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.date.alias["%Y/%m/%d"],
      augend.constant.alias.alpha,
      augend.constant.alias.Alpha,
    },
    mygroup = {
      augend.constant.new({
        elements = { "and", "or" },
        word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
        cyclic = true, -- "or" is incremented into "and".
      }),
      augend.constant.new({
        elements = { "True", "False" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "public", "private" },
        word = true,
        cyclic = true,
      }),
      augend.constant.new({
        elements = { "&&", "||" },
        word = false,
        cyclic = true,
      }),
      augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
      augend.constant.alias.bool, -- boolean value (true <-> false)
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.semver.alias.semver,
    },
  })

  vim.cmd([[
    " enable only for specific FileType
    autocmd FileType typescript,javascript lua vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", require("dial.map").inc_normal("typescript"), {noremap = true})
  ]])
end

return M
