local M = {}

function M.config()
  saturn.plugins.tabout = {
    active = true,
    on_config_done = nil,
    tabkey = "<tab>", -- key to trigger tabout, set to an empty string to disable
    backwards_tabkey = "<s-tab>", -- key to trigger backwards tabout, set to an empty string to disable
    act_as_tab = true, -- shift content if tab out is not possible
    act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
    default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
    default_shift_tab = "<C-d>", -- reverse shift default action,
    enable_backwards = false, -- well ...
    completion = true, -- if the tabkey is used in a completion pum
    tabouts = {
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      { open = "{", close = "}" },
    },
    ignore_beginning = false, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
    exclude = { "markdown" }, -- tabout will ignore these filetypes
  }
end

function M.setup()
  local present, tabout = pcall(require, "tabout")
  if not present then
    return
  end

  tabout.setup(saturn.plugins.tabout)
  if saturn.plugins.tabout.on_config_done then
    saturn.plugins.tabout.on_config_done(tabout)
  end
end

return M
