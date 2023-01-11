local util = require("saturn.utils.plugin")

return {
  {
    "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    keys = {
      { "<leader>ee", "<cmd>NvimTreeToggle<CR>", desc = "Project" },
    },
    config = function()
      local nvim_tree = require("nvim-tree")
      local conf = require("saturn.plugins.editor.nvim-tree").config


      -- saturn.plugins.which_key.mappings["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" }
      conf._setup_called = true

      -- Implicitly update nvim-tree when project module is active
      conf.setup.respect_buf_cwd = true
      conf.setup.update_cwd = true
      conf.setup.update_focused_file = { enable = true, update_cwd = true }

      local function telescope_find_files(_)
        require("saturn.core.nvimtree").start_telescope("find_files")
      end

      local function telescope_live_grep(_)
        require("saturn.core.nvimtree").start_telescope("live_grep")
      end

      -- Add useful keymaps
      if #conf.setup.view.mappings.list == 0 then
        conf.setup.view.mappings.list = {
          { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
          { key = "n", action = "close_node" },
          { key = "v", action = "vsplit" },
          { key = "C", action = "cd" },
          { key = "gtf", action = "telescope_find_files", action_cb = telescope_find_files },
          { key = "gtg", action = "telescope_live_grep", action_cb = telescope_live_grep },
        }
      end

      nvim_tree.setup(conf.setup)
    end,
  },

  -- project
  {
    "ahmedkhalf/project.nvim",
    config = function()
      local project = require("project_nvim")
      project.setup({
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml" },
      })
    end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    keys = {
      { "<leader><cr>p", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "python" },
      { "<leader><cr>f", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
      { "<leader><cr>h", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal" },
      { "<leader><cr>v", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical" },
      { "<leader>gg", "<cmd>lua require 'saturn.plugins.editor.toggleterm'.lazygit_toggle()<cr>", desc = "LazyGit" },
    },
    config = function()
      local toggleterm = require("toggleterm")
      local term = require("saturn.plugins.editor.toggleterm")
      toggleterm.setup(term.config)
    end,
  },

  -- neogit
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
    config = true,
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
      },
      {
        "LukasPietzschmann/telescope-tabs",
      },
      {
        "nvim-telescope/telescope-media-files.nvim",
      },
      {
        "nvim-telescope/telescope-file-browser.nvim"
      },
      {
        "tom-anders/telescope-vim-bookmarks.nvim",
      },
    },
    config = function()
      local actions = require("telescope.actions")
      local fb_actions = require('telescope').extensions.file_browser.actions
      conf = {
        theme = "dropdown", ---@type telescope_themes
        defaults = {
          prompt_prefix = saturn.icons.ui.Telescope .. " ",
          selection_caret = saturn.icons.ui.Forward .. " ",
          entry_prefix = "  ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = nil,
          layout_strategy = nil,
          layout_config = nil,
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
          },
          ---@usage Mappings are fully customizable. Many familiar mapping patterns are setup as defaults.
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,

              ["<C-e>"] = actions.move_selection_next,
              ["<C-u>"] = actions.move_selection_previous,

              ["<C-b>"] = actions.results_scrolling_up,
              ["<C-f>"] = actions.results_scrolling_down,

              ["<C-c>"] = actions.close,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,

              ["<CR>"] = actions.select_default,
              ["<C-s>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,

              ["<c-d>"] = require("telescope.actions").delete_buffer,

              -- ["<C-u>"] = actions.preview_scrolling_up,
              -- ["<C-d>"] = actions.preview_scrolling_down,

              -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<Tab>"] = actions.close,
              ["<S-Tab>"] = actions.close,
              -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
              ["<C-h>"] = actions.which_key, -- keys from pressing <C-h>
              ["<esc>"] = actions.close,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-b>"] = actions.results_scrolling_up,
              ["<C-f>"] = actions.results_scrolling_down,

              ["<Tab>"] = actions.close,
              ["<S-Tab>"] = actions.close,
              -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

              ["e"] = actions.move_selection_next,
              ["u"] = actions.move_selection_previous,
              ["U"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["E"] = actions.move_to_bottom,
              ["q"] = actions.close,
              ["dd"] = require("telescope.actions").delete_buffer,
              ["s"] = actions.select_horizontal,
              ["v"] = actions.select_vertical,
              ["t"] = actions.select_tab,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,

              ["?"] = actions.which_key,
            },
          },
          file_ignore_patterns = {
            ".git/",
            "target/",
            "docs/",
            "vendor/*",
            "%.lock",
            "__pycache__/*",
            "%.sqlite3",
            "%.ipynb",
            "node_modules/*",
            "%.svg",
            "%.otf",
            "%.ttf",
            "%.webp",
            ".dart_tool/",
            ".github/",
            ".gradle/",
            ".idea/",
            ".settings/",
            ".vscode/",
            "__pycache__/",
            "build/",
            "env/",
            "gradle/",
            "node_modules/",
            "%.pdb",
            "%.dll",
            "%.class",
            "%.exe",
            "%.cache",
            "%.ico",
            "%.pdf",
            "%.dylib",
            "%.jar",
            "%.docx",
            "%.met",
            "smalljre_*/*",
            ".vale/",
            "%.burp",
            "%.mp4",
            "%.mkv",
            "%.rar",
            "%.zip",
            "%.7z",
            "%.tar",
            "%.bz2",
            "%.epub",
            "%.flac",
            "%.tar.gz",
          },
          path_display = { "smart" },
          winblend = 0,
          border = {},
          borderchars = nil,
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          live_grep = {
            --@usage don't include the filename in the search results
            only_sort_text = true,
          },
          grep_string = {
            only_sort_text = true,
          },
          buffers = {
            initial_mode = "normal",
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
          planets = {
            show_pluto = true,
            show_moon = true,
          },
          git_files = {
            hidden = true,
            show_untracked = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
          file_browser = {
            mappings = {
              ['n'] = {
                ['c'] = fb_actions.create,
                ['r'] = fb_actions.rename,
                ['d'] = fb_actions.remove,
                ['o'] = fb_actions.open,
                ['p'] = fb_actions.goto_parent_dir,
              },
            },
          },
        },
      }

      local previewers = require "telescope.previewers"
      local sorters = require "telescope.sorters"

      conf = vim.tbl_extend("keep", {
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        file_sorter = sorters.get_fuzzy_file,
        generic_sorter = sorters.get_generic_fuzzy_sorter,
      }, conf)

      local telescope = require "telescope"

      local theme = require("telescope.themes")["get_" .. (conf.theme or "")]
      if theme then
        conf.defaults = theme(conf.defaults)
      end

      telescope.setup(conf)

      pcall(function()
        require("telescope").load_extension "projects"
      end)

      if conf.extensions and conf.extensions.fzf then
        pcall(function()
          require("telescope").load_extension "fzf"
        end)
      end
      pcall(function()
        require("telescope").load_extension "dotfiles"
      end)
      pcall(function()
        require("telescope").load_extension "file_browser"
      end)
    end,
    keys = {
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File Explorer" },
      { "<leader>ff", util.telescope("find_files"), desc = "Find Files (root dir)" },
      { "<leader>fF", util.telescope("find_files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fM", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", desc = "Media" },
      { "<leader>fd", "<cmd>Telescope dotfiles<cr>", desc = "Dotfiles" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>ga", "<cmd>Telescope git_status<CR>", desc = "status" },
      { "<leader>ss", util.telescope("live_grep"), desc = "Find in Files (Grep)" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sg", util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>sG", util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>sr", "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sl", "<cmd>Telescope resume<cr>", desc = "Last Search" },
      { "<leader>bb", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>ha", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>hc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>hf", "<cmd>Telescope filetypes<cr>", desc = "File Types" },
      { "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>hm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>ho", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>hs", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>ht", "<cmd>Telescope builtin<cr>", desc = "Telescope" },
      { "<leader>hp", "<cmd>lua require('telescope.plugins').colorscheme({enable_preview = true})<cr>", desc = "Colorscheme with Preview" },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = { spelling = true },
        key_labels = { ["<leader>"] = "SPC" },

        popup_mappings = {
          scroll_down = "<c-e>", -- binding to scroll down inside the popup
          scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
      })
      wk.register({
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>e"] = { name = "+explorer" },
        ["<leader>f"] = { name = "+file" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>t"] = { name = "+trouble/todo" },
        ["<leader>p"] = { name = "+plugin" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader><tab>"] = { name = "+tabs" },
      })

      wk.register({ k = { name = "inside" }, a = { name = "around" } }, { mode = "v", preset = true })
    end,
  },
  {

    "lewis6991/gitsigns.nvim",
    config = {

      signs = {
        add = {
          text = saturn.icons.ui.BoldLineLeft,
        },
        change = {
          text = saturn.icons.ui.BoldLineLeft,
        },
        delete = {
          text = saturn.icons.ui.Triangle,
        },
        topdelete = {
          text = saturn.icons.ui.Triangle,
        },
        changedelete = {
          text = saturn.icons.ui.BoldLineLeft,
        },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]g", gs.prev_hunk, "Next Hunk")
        map("n", "[g", gs.next_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "kh", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
    event = "BufReadPre",
  },

  -- references
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
      require("illuminate").configure({ delay = 200 })
    end,
    -- stylua: ignore
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
  },

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {
      { "<leader>ud", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>uD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>tt", "<cmd>TroubleToggle<cr>", desc = "trouble" },
      { "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "workspace" },
      { "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "document" },
      { "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", desc = "quickfix" },
      { "<leader>tl", "<cmd>TroubleToggle loclist<cr>", desc = "loclist" },
      { "<leader>tr", "<cmd>TroubleToggle lsp_references<cr>", desc = "references" },
    },
    config = {
      action_keys = {
        -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
        open_split = { "s" }, -- open buffer in new split
        open_vsplit = { "v" }, -- open buffer in new vsplit
        open_tab = { "t" }, -- open buffer in new tab
        jump_close = { "j" }, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "H", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = { "zM", "zm" }, -- close all folds
        open_folds = { "zR", "zr" }, -- open all folds
        toggle_fold = { "zA", "za" }, -- toggle fold of current file
        previous = "u", -- previous item
        next = "e", -- next item
      },
      use_diagnostic_signs = true
    },
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
    keys = {
      { "<leader>ti", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "<leader>tn", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>to", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
      { "<leader>tk", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo Trouble" },
      { "<leader>tf", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
    },
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
      { "<leader>sw", function() require('spectre').open_visual({select_word=true}) end, desc = "Replace Word" },
      { "<leader>sf", function() require('spectre').open_file_search() end, desc = "Replace Buffer" },
    },
    config = true,
  },

  -- diffview
  {
    "sindrets/diffview.nvim",
    enabled = saturn.enable_extra_plugins,
    keys = {
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "file history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "current file history" },
      { "<leader>go", "<cmd>DiffviewOpen<cr>", desc = "diffview open" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "diffview close" },
      { "<leader>gt", "<cmd>DiffviewToggleFiles<cr>", desc = "toggle files" },
      { "<leader>gh", "<cmd>'<,'>DiffviewFileHistory<cr>", desc = "file history", mode = "v" },
    },
    cmd = {
      "DiffviewFileHistory",
      "DiffviewFileHistory",
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFileHistory",
    },
    config = true,
  },
  {
    "simrat39/symbols-outline.nvim",
    keys = { { "<leader>eo", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = {
      keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-k>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
      },
      symbols = {
        File = { icon = saturn.icons.ui.File, hl = "CmpItemKindFile" },
        Module = { icon = saturn.icons.kind.Module, hl = "CmpItemKindModule" },
        Namespace = { icon = saturn.icons.kind.Module, hl = "CmpItemKindModule" },
        Package = { icon = saturn.icons.kind.Module, hl = "CmpItemKindModule" },
        Class = { icon = saturn.icons.kind.Class, hl = "CmpItemKindClass" },
        Method = { icon = saturn.icons.kind.Method, hl = "CmpItemKindMethod" },
        Property = { icon = saturn.icons.kind.Property, hl = "CmpItemKindProperty" },
        Field = { icon = saturn.icons.kind.Field, hl = "CmpItemKindField" },
        Constructor = { icon = saturn.icons.kind.Constructor, hl = "CmpItemKindConstructor" },
        Enum = { icon = saturn.icons.kind.Enum, hl = "CmpItemKindEnum" },
        Interface = { icon = saturn.icons.kind.Interface, hl = "CmpItemKindInterface" },
        Function = { icon = saturn.icons.kind.Function, hl = "CmpItemKindFunction" },
        Variable = { icon = saturn.icons.kind.Variable, hl = "CmpItemKindVariable" },
        Constant = { icon = saturn.icons.kind.Constant, hl = "CmpItemKindConstant" },
        String = { icon = saturn.icons.kind.String, hl = "TSString" },
        Number = { icon = saturn.icons.kind.Number, hl = "TSNumber" },
        Boolean = { icon = saturn.icons.kind.Boolean, hl = "TSBoolean" },
        Array = { icon = saturn.icons.kind.Array, hl = "TSKeyword" },
        Object = { icon = saturn.icons.kind.Object, hl = "TSKeyword" },
        Key = { icon = saturn.icons.kind.Keyword, hl = "CmpItemKeyword" },
        Null = { icon = "NULL", hl = "TSKeyword" },
        EnumMember = { icon = saturn.icons.kind.EnumMember, hl = "CmpItemKindEnumMember" },
        Struct = { icon = saturn.icons.kind.Struct, hl = "CmpItemKindStruct" },
        Event = { icon = saturn.icons.kind.Event, hl = "CmpItemKindEvent" },
        Operator = { icon = saturn.icons.kind.Operator, hl = "CmpItemKindOperator" },
        TypeParameter = { icon = saturn.icons.kind.TypeParameter, hl = "CmpItemKindTypeParameter" },
      },
    },
  },

  -- harpoon
  {
    "christianchiarulli/harpoon",
    keys = {
      { "]h", '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" },
      { "[h", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" },
      { "<leader>fh", "<cmd>Telescope harpoon marks<cr>", "Search Mark Files" },
      { "<leader>m;", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" },
      { "<leader>mm", '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },
    },
    enabled = saturn.enable_extra_plugins,
    config = true,
  },

  --TODO:lab
  --TODO:dap
}
