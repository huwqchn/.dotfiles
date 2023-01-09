local M = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
}

function M.init()
  saturn.plugins.autopairs = {
    ---@usage  modifies the function or method delimiter by filetypes
    map_char = {
      all = "(",
      tex = "{",
    },
    ---@usage check bracket in same line
    enable_check_bracket_line = false,
    ---@usage check treesitter
    check_ts = true,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = false,
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
    enable_moveright = true,
    ---@usage disable when recording or executing a macro
    disable_in_macro = false,
    ---@usage add bracket pairs after quote
    enable_afterquote = true,
    ---@usage map the <BS> key
    map_bs = true,
    ---@usage map <c-w> to delete a pair if possible
    map_c_w = false,
    ---@usage disable when insert after visual block mode
    disable_in_visualblock = false,
    ---@usage  change default fast_wrap
    fast_wrap = {
      map = "<M-w>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset = 0, -- Offset from pattern match
      end_key = "$",
      keys = "qwfpgjluyzxcvbkmarstdhneio",
      check_comma = true,
      highlight = "Search",
      highlight_grey = "Comment",
    },
  }
end

local function on_confirm_done(...)
  require("nvim-autopairs.completion.cmp").on_confirm_done()(...)
end

function M.config()
  local autopairs = require("nvim-autopairs")
  local Rule = require("nvim-autopairs.rule")

  autopairs.setup({
    check_ts = saturn.plugins.autopairs.check_ts,
    enable_check_bracket_line = saturn.plugins.autopairs.enable_check_bracket_line,
    ts_config = saturn.plugins.autopairs.ts_config,
    disable_filetype = saturn.plugins.autopairs.disable_filetype,
    disable_in_macro = saturn.plugins.autopairs.disable_in_macro,
    ignored_next_char = saturn.plugins.autopairs.ignored_next_char,
    enable_moveright = saturn.plugins.autopairs.enable_moveright,
    enable_afterquote = saturn.plugins.autopairs.enable_afterquote,
    map_c_w = saturn.plugins.autopairs.map_c_w,
    map_bs = saturn.plugins.autopairs.map_bs,
    disable_in_visualblock = saturn.plugins.autopairs.disable_in_visualblock,
    fast_wrap = saturn.plugins.autopairs.fast_wrap,
  })

  pcall(function()
    require("nvim-treesitter.configs").setup({ autopairs = { enable = true } })
  end)
  local ts_conds = require("nvim-autopairs.ts-conds")

  -- press % => %% is only inside comment or string
  autopairs.add_rules({
    Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
    Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
  })

  if saturn.plugins.autopairs.on_config_done then
    saturn.plugins.autopairs.on_config_done(autopairs)
  end
  pcall(function()
    require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:off("confirm_done", on_confirm_done)
    cmp.event:on("confirm_done", on_confirm_done)
  end)
end

return M
