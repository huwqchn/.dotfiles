local present, searchbox = pcall(require, "searchbox")
if not present then
  return
end

searchbox.setup({
  icons = {
    search = ' ',
    case_sensitive = ' ',
    pattern = ' ',
    fuzzy = ' ',
  },
  popup = {
    relative = 'win',
    position = {
      row = '5%',
      col = '95%',
    },
    size = 30,
    border = {
      style = 'rounded',
      highlight = 'FloatBorder',
      text = {
        top = ' Search ',
        top_align = 'left',
      },
    },
    win_options = {
      winhighlight = 'Normal:Normal',
    },
  },
  hooks = {
    before_mount = function(input)
      -- code
    end,
    after_mount = function(input)
      -- code
    end,
    on_done = function(value, search_type)
      -- code
    end
  }
})
vim.api.nvim_set_keymap(
  'n',
  '/',
  ':SearchBoxIncSearch<CR>',
  {noremap = true}
)
vim.api.nvim_set_keymap(
  'x',
  '/',
  ':SearchBoxIncSearch visual_mode=true<CR>',
  {noremap = true}
)
