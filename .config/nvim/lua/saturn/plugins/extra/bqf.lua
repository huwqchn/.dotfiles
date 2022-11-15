local M = {}

function M.config()
  saturn.plugins.bqf = {
    active = true,
    on_config_done = nil,
    auto_enable = true,
    magic_window =  true,
    auto_resize_height = false,
    preview = {
        auto_preview = false,
        border_chars = {'│', '│', '─', '─', '╭', '╮', '╰', '╯', '█'},
        show_title = true,
        delay_syntax = 50,
        win_height = 15,
        win_vheight = 15,
        wrap = false,
    },
    func_map = {
      tab = "t",
      openc = "o",
      drop = "O",
      split = "s",
      vsplit = "v",
      stoggleup = "M",
      stoggledown = "m",
      stogglevm = "m",
      filterr = "f",
      filter = "F",
      prevhist = "<",
      nexthist = ">",
      sclear = "c",
      ptoggleauto = "p",
      ptogglemode = "P",
    },
    filter = {
        fzf = {
            action_for = {
                ['<leader>qt'] = {
                    description = [[press ctrl-t to open up the item in a new tab]],
                    default = 'tabedit'
                },
                ['<leader>qv'] = {
                    description = [[press ctrl-v to open up the item in a new vertical split]],
                    default = 'vsplit'
                },
                ['<leader>qs'] = {
                    description = [[press ctrl-x to open up the item in a new horizontal split]],
                    default = 'split'
                },
                ['<leader>qq'] = {
                    description = [[press ctrl-q to toggle sign for the selected items]],
                    default = 'signtoggle'
                },
                ['<leader>qc'] = {
                    description = [[press ctrl-c to close quickfix window and abort fzf]],
                    default = 'closeall'
                }
            },
            extra_opts = {
                description = 'extra options for fzf',
                default = {'--bind', 'ctrl-o:toggle-all'}
            }
        }
    }
  }
end


function M.setup()
  local status_ok, bqf = pcall(require, "bqf")
  if not status_ok then
    return
  end

  bqf:setup(saturn.plugins.bqf)
  if saturn.plugins.bqf.on_config_done then
    saturn.plugins.bqf.on_config_done(bqf)
  end
end

return M
