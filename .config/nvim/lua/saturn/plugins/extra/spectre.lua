local M = {}

function M.config()
  saturn.plugins.spectre = {
    active = true,
    ocolor_devicons = true,
    open_cmd = "vnew",
    live_update = false, -- auto excute search again when you write any file in vim
    line_sep_start = "┌-----------------------------------------",
    result_padding = "¦  ",
    line_sep = "└-----------------------------------------",
    highlight = {
      ui = "String",
      search = "DiffChange",
      replace = "DiffDelete",
    },
    mapping = {
      ["toggle_line"] = {
        map = "tt",
        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
        desc = "toggle current item",
      },
      ["enter_file"] = {
        map = "<cr>",
        cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
        desc = "goto current file",
      },
      ["send_to_qf"] = {
        map = "Q",
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all item to quickfix",
      },
      ["replace_cmd"] = {
        map = "c",
        cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
        desc = "input replace vim command",
      },
      ["show_option_menu"] = {
        map = "o",
        cmd = "<cmd>lua require('spectre').show_options()<CR>",
        desc = "show option",
      },
      ["run_current_replace"] = {
        map = "R",
        cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
        desc = "replace current line",
      },
      ["run_replace"] = {
        map = "r",
        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
        desc = "replace all",
      },
      ["change_view_mode"] = {
        map = "m",
        cmd = "<cmd>lua require('spectre').change_view()<CR>",
        desc = "change result view mode",
      },
      ["change_replace_sed"] = {
        map = "ts",
        cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
        desc = "use sed to replace",
      },
      ["change_replace_oxi"] = {
        map = "to",
        cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
        desc = "use oxi to replace",
      },
      ["toggle_live_update"] = {
        map = "tu",
        cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
        desc = "update change when vim write file.",
      },
      ["toggle_ignore_case"] = {
        map = "ti",
        cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
        desc = "toggle ignore case",
      },
      ["toggle_ignore_hidden"] = {
        map = "th",
        cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
        desc = "toggle search hidden",
      },
      ["resume_last_search"] = {
        map = "l",
        cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
        desc = "resume last search before close",
      },
      -- you can put your mapping here it only use normal mode
    },
    find_engine = {
      -- rg is map with finder_cmd
      ["rg"] = {
        cmd = "rg",
        -- default args
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        options = {
          ["ignore-case"] = {
            value = "--ignore-case",
            icon = "[I]",
            desc = "ignore case",
          },
          ["hidden"] = {
            value = "--hidden",
            desc = "hidden file",
            icon = "[H]",
          },
          -- you can put any rg search option you want here it can toggle with
          -- show_option function
        },
      },
      ["ag"] = {
        cmd = "ag",
        args = {
          "--vimgrep",
          "-s",
        },
        options = {
          ["ignore-case"] = {
            value = "-i",
            icon = "[I]",
            desc = "ignore case",
          },
          ["hidden"] = {
            value = "--hidden",
            desc = "hidden file",
            icon = "[H]",
          },
        },
      },
    },
    replace_engine = {
      ["sed"] = {
        cmd = "sed",
        args = nil,
        options = {
          ["ignore-case"] = {
            value = "--ignore-case",
            icon = "[I]",
            desc = "ignore case",
          },
        },
      },
      -- call rust code by nvim-oxi to replace
      ["oxi"] = {
        cmd = "oxi",
        args = {},
        options = {
          ["ignore-case"] = {
            value = "i",
            icon = "[I]",
            desc = "ignore case",
          },
        },
      },
    },
    default = {
      find = {
        --pick one of item in find_engine
        cmd = "rg",
        options = { "ignore-case" },
      },
      replace = {
        --pick one of item in replace_engine
        cmd = "sed",
      },
    },
    replace_vim_cmd = "cdo",
    is_open_target_win = true, --open file on opener window
    is_insert_mode = false, -- start open panel on is_insert_moden_config_done = nil,
  }
  if saturn.plugins.spectre.active then
    saturn.plugins.whichkey.mappings["r"] = {
      name = "Replace",
      r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
      w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
      f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
    }
  end
end

function M.setup()
  local present, spectre = pcall(require, "spectre")
  if not present then
    return
  end
  spectre.setup(saturn.plugins.spectre)
  if saturn.plugins.spectre.on_config_done then
    saturn.plugins.spectre.on_config_done(spectre)
  end
end

return M
