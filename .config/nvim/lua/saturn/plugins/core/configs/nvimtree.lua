local M = {}

function M.config()
  saturn.plugins.core.nvimtree = {
    active = true,
    on_config_done = nil,
    setup = {
      ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
      },
      auto_reload_on_write = false,
      hijack_directories = {
        enable = false,
      },
      update_cwd = true,
      diagnostics = {
        enable = saturn.use_icons,
        show_on_dirs = false,
        icons = {
          hint = saturn.icons.diagnostics.BoldHint,
          info = saturn.icons.diagnostics.BoldInformation,
          warning = saturn.icons.diagnostics.BoldWarning,
          error = saturn.icons.diagnostics.BoldError,
        },
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
      },
      system_open = {
        cmd = nil,
        args = {},
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 200,
      },
      view = {
        width = 30,
        hide_root_folder = false,
        side = "left",
        mappings = {
          custom_only = false,
          list = {},
        },
        number = false,
        relativenumber = false,
        signcolumn = "yes",
      },
      renderer = {
        indent_markers = {
          enable = false,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            none = " ",
          },
        },
        icons = {
          webdev_colors = saturn.use_icons,
          show = {
            git = saturn.use_icons,
            folder = saturn.use_icons,
            file = saturn.use_icons,
            folder_arrow = saturn.use_icons,
          },
          glyphs = {
            default = saturn.icons.ui.Text,
            symlink = saturn.icons.ui.FileSymlink,
            git = {
              deleted = saturn.icons.git.FileDeleted,
              ignored = saturn.icons.git.FileIgnored,
              renamed = saturn.icons.git.FileRenamed,
              staged = saturn.icons.git.FileStaged,
              unmerged = saturn.icons.git.FileUnmerged,
              unstaged = saturn.icons.git.FileUnstaged,
              untracked = saturn.icons.git.FileUntracked,
            },
            folder = {
              default = saturn.icons.ui.Folder,
              empty = saturn.icons.ui.EmptyFolder,
              empty_open = saturn.icons.ui.EmptyFolderOpen,
              open = saturn.icons.ui.FolderOpen,
              symlink = saturn.icons.ui.FolderSymlink,
            },
          },
        },
        highlight_git = true,
        group_empty = false,
        root_folder_modifier = ":t",
      },
      filters = {
        dotfiles = false,
        custom = { "node_modules", "\\.cache" },
        exclude = {},
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          diagnostics = false,
          git = false,
          profile = false,
        },
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        open_file = {
          quit_on_open = false,
          resize_window = false,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
      },
    },
  }
end

function M.setup()
  local status_ok, nvim_tree = pcall(require, "nvim-tree")
  if not status_ok then
    print("Failed to load nvim-tree")
    return
  end


  if saturn.plugins.core.nvimtree._setup_called then
    print("ignoring repeated setup call for nvim-tree, see kyazdani42/nvim-tree.lua#1308")
    return
  end

  saturn.plugins.core.which_key.mappings["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" }
  saturn.plugins.core.nvimtree._setup_called = true

  -- Implicitly update nvim-tree when project module is active
  if saturn.plugins.core.project.active then
    saturn.plugins.core.nvimtree.setup.respect_buf_cwd = true
    saturn.plugins.core.nvimtree.setup.update_cwd = true
    saturn.plugins.core.nvimtree.setup.update_focused_file = { enable = true, update_cwd = true }
  end

  local function telescope_find_files(_)
    require("saturn.plugins.core.configs.nvimtree").start_telescope "find_files"
  end

  local function telescope_live_grep(_)
    require("saturn.plugins.core.configs.nvimtree").start_telescope "live_grep"
  end

  -- Add useful keymaps
  if #saturn.plugins.core.nvimtree.setup.view.mappings.list == 0 then
    saturn.plugins.core.nvimtree.setup.view.mappings.list = {
      { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
      { key = "h", action = "close_node" },
      { key = "v", action = "vsplit" },
      { key = "C", action = "cd" },
      { key = "gtf", action = "telescope_find_files", action_cb = telescope_find_files },
      { key = "gtg", action = "telescope_live_grep", action_cb = telescope_live_grep },
    }
  end

  nvim_tree.setup(saturn.plugins.core.nvimtree.setup)

  if saturn.plugins.core.nvimtree.on_config_done then
    saturn.plugins.core.nvimtree.on_config_done(nvim_tree)
  end
end

function M.start_telescope(telescope_mode)
  local node = require("nvim-tree.lib").get_node_at_cursor()
  local abspath = node.link_to or node.absolute_path
  local is_folder = node.open ~= nil
  local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
  require("telescope.builtin")[telescope_mode] {
    cwd = basedir,
  }
end

return M
