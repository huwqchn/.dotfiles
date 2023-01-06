local M = {
  "christianchiarulli/lir.nvim",
  keys = {
    { "<leader>ef", "<cmd>lua require'lir.float'.toggle()<cr>", desc = "Toggle Floating Lir" },
  },
}

saturn.plugins.lir = {
  on_config_done = nil,
  icon = "",
}

function M.config_icon()
  local actions = require("lir.actions")
  local mark_actions = require("lir.mark.actions")
  local clipboard_actions = require("lir.clipboard.actions")

  saturn.plugins.lir = vim.tbl_extend("force", saturn.plugins.lir, {
    show_hidden_files = false,
    devicons_enable = true,
    mappings = {
      ["l"] = actions.edit,
      ["<CR>"] = actions.edit,
      ["<C-s>"] = actions.split,
      ["v"] = actions.vsplit,
      ["<C-t>"] = actions.tabedit,

      ["n"] = actions.up,
      ["q"] = actions.quit,

      ["A"] = actions.mkdir,
      ["a"] = actions.newfile,
      ["r"] = actions.rename,
      ["@"] = actions.cd,
      ["Y"] = actions.yank_path,
      ["i"] = actions.toggle_show_hidden,
      ["d"] = actions.delete,

      ["J"] = function()
        mark_actions.toggle_mark()
        vim.cmd("normal! j")
      end,
      ["c"] = clipboard_actions.copy,
      ["x"] = clipboard_actions.cut,
      ["p"] = clipboard_actions.paste,
    },
    float = {
      winblend = 0,
      curdir_window = {
        enable = false,
        highlight_dirname = true,
      },

      -- -- You can define a function that returns a table to be passed as the third
      -- -- argument of nvim_open_win().
      win_opts = function()
        local width = math.floor(vim.o.columns * 0.7)
        local height = math.floor(vim.o.lines * 0.7)
        return {
          border = "rounded",
          width = width,
          height = height,
          -- row = 1,
          -- col = math.floor((vim.o.columns - width) / 2),
        }
      end,
    },
    hide_cursor = false,
    on_init = function()
      -- use visual mode
      vim.api.nvim_buf_set_keymap(
        0,
        "x",
        "J",
        ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
        { noremap = true, silent = true }
      )

      -- echo cwd
      -- vim.api.nvim_echo({ { vim.fn.expand "%:p", "Normal" } }, false, {})
    end,
  })
  local function get_hl_by_name(name)
    local ret = vim.api.nvim_get_hl_by_name(name.group, true)
    return string.format("#%06x", ret[name.property])
  end

  local found, icon_hl = pcall(get_hl_by_name, { group = "NvimTreeFolderIcon", property = "foreground" })
  if not found then
    icon_hl = "#42A5F5"
  end

  require("nvim-web-devicons").set_icon({
    lir_folder_icon = {
      icon = saturn.plugins.lir.icon,
      color = icon_hl,
      name = "LirFolderNode",
    },
  })
end

function M.config()
  local lir = require("lir")
  lir.setup(saturn.plugins.lir)

  if saturn.plugins.lir.on_config_done then
    saturn.plugins.lir.on_config_done(lir)
  end
end

return M
