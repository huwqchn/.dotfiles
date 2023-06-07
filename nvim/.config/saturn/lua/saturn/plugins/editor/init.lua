local Util = require("saturn.utils.plugin")

return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({
            toggle = true,
            position = "left",
            dir = require("saturn.utils.plugin").get_root(),
          })
        end,
        desc = "Filesystem Left(root dir)",
      },
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, position = "left", dir = vim.loop.cwd() })
        end,
        desc = "Filesystem Left(cwd)",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      close_if_last_window = true,
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
        filtered_items = {
          hide_dofiles = true,
        },
      },
      window = {
        -- width = 30,
        mappings = {
          ["<space>"] = "none",
          ["<cr>"] = "open_with_window_picker",
          ["e"] = "none",
          ["E"] = "toggle_auto_expand_width",
          ["N"] = {
            "toggle_node",
            nowait = false,
          },
          ["w"] = "open",
        },
      },
    },
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
      { "<leader><cr><cr>", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
      { "<leader><cr>h", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal" },
      { "<leader><cr>v", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical" },
      { "<leader><cr><tab>", "<cmd>ToggleTerm direction=tab<cr>", desc = "Tab" },
      { "<leader>gg", "<cmd>lua require 'saturn.plugins.editor.toggleterm'.lazygit_toggle()<cr>", desc = "LazyGit" },
      { "<leader>xb", "<cmd>lua require 'saturn.plugins.editor.toggleterm'.btop_toggle()<cr>", desc = "btop" },
      { "<M-S-1>" },
      { "<M-S-2>" },
      { "<M-S-3>" },
    },
    config = function()
      local toggleterm = require("toggleterm")
      local term = require("saturn.plugins.editor.toggleterm")
      toggleterm.setup(term.config)
      for i, exec in pairs(term.config.execs) do
        local direction = exec[4] or term.config.direction

        local opts = {
          cmd = exec[1] or term.config.shell,
          keymap = exec[2],
          label = exec[3],
          -- NOTE: unable to consistently bind id/count <= 9, see #2146
          count = i + 100,
          direction = direction,
          size = function()
            return term.get_dynamic_terminal_size(direction, exec[5])
          end,
        }

        term.add_exec(opts)
      end
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
        "nvim-telescope/telescope-file-browser.nvim",
      },
      {
        "nvim-telescope/telescope-ui-select.nvim",
      },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
      },
      { "project.nvim" },
    },
    config = function()
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions
      local conf = {
        theme = "dropdown", --@type telescope_themes
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
              ["<C-i>"] = actions.move_selection_previous,

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
              ["i"] = actions.move_selection_previous,
              ["I"] = actions.move_to_top,
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
              ["n"] = {
                ["c"] = fb_actions.create,
                ["r"] = fb_actions.rename,
                ["d"] = fb_actions.remove,
                ["o"] = fb_actions.open,
                ["p"] = fb_actions.goto_parent_dir,
              },
            },
          },
        },
      }

      local previewers = require("telescope.previewers")
      local sorters = require("telescope.sorters")

      conf = vim.tbl_extend("keep", {
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        file_sorter = sorters.get_fuzzy_file,
        generic_sorter = sorters.get_generic_fuzzy_sorter,
      }, conf)

      local telescope = require("telescope")

      local theme = require("telescope.themes")["get_" .. (conf.theme or "")]
      if theme then
        conf.defaults = theme(conf.defaults)
      end

      telescope.setup(conf)

      pcall(function()
        require("telescope").load_extension("projects")
      end)

      if conf.extensions and conf.extensions.fzf then
        pcall(function()
          require("telescope").load_extension("fzf")
        end)
      end
      pcall(function()
        require("telescope").load_extension("dotfiles")
      end)
      pcall(function()
        require("telescope").load_extension("file_browser")
      end)
      pcall(function()
        require("telescope").load_extension("ui-select")
      end)
      pcall(function()
        require("telescope").load_extension("live_grep_args")
      end)
      pcall(function()
        require("telescope").load_extension("noice")
      end)
      pcall(function()
        require("telescope").load_extension("macros")
      end)
    end,
    keys = {
      -- { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>bb", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File Explorer" },
      { "<leader>ff", Util.telescope("find_files"), desc = "Find Files (root dir)" },
      { "<leader>fF", Util.telescope("find_files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fM", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", desc = "Media" },
      { "<leader>fd", "<cmd>Telescope dotfiles<cr>", desc = "Dotfiles" },
      { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
      {
        "<leader>fg",
        "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        desc = "Live Grep Args",
      },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>ga", "<cmd>Telescope git_status<CR>", desc = "status" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sf", "<cmd>Telescope filetypes<cr>", desc = "File Types" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sw", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>sW", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sr", "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sl", "<cmd>Telescope resume<cr>", desc = "Last Search" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>si", "<cmd>Telescope builtin<cr>", desc = "Telescope" },
      {
        "<leader>sp",
        "<cmd>lua require('telescope.plugins').colorscheme({enable_preview = true})<cr>",
        desc = "Colorscheme with Preview",
      },
      {
        "<leader>ss",
        Util.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        Util.telescope("lsp_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol (Workspace)",
      },
      {
        "<leader>s<tab>",
        "<cmd>lua require('telescope').extensions['telescope-tabs'].list_tabs(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal', prompt_title='Tabs'})<cr>",
        desc = "Find Tab",
      },
      {
        "<leader>sq",
        "<cmd>Telescope macros<cr>",
        desc = "Macros",
      },
    },
  },

  {
    "folke/which-key.nvim",
    keys = {
      { "<leader>", mode = { "n", "v" } },
      { "g", mode = { "n", "v" } },
      { "s", mode = { "n", "v" } },
      { "[", mode = { "n", "v" } },
      { "]", mode = { "n", "v" } },
    },
    init = function()
      saturn.plugins.which_key = {
        mappings = {
          mode = { "n", "v" },
          ["g"] = { name = "+goto" },
          ["s"] = { name = "+split/surroud/select" },
          ["]"] = { name = "+next" },
          ["["] = { name = "+prev" },
          ["<leader>a"] = { name = "+AI support" },
          ["<leader>b"] = { name = "+buffer" },
          ["<leader>c"] = { name = "+code" },
          ["<leader>d"] = { name = "+debug" },
          -- ["<leader>e"] = { name = "+explorer" },
          ["<leader>f"] = { name = "+file" },
          ["<leader>g"] = { name = "+git" },
          ["<leader>j"] = { name = "+jump" },
          ["<leader>m"] = { name = "+marks" },
          ["<leader>p"] = { name = "+plugin" },
          ["<leader>q"] = { name = "+session" },
          ["<leader>r"] = { name = "+refactor/replace" },
          ["<leader>s"] = { name = "+search" },
          ["<leader>t"] = { name = "+test" },
          ["<leader>u"] = { name = "+ui" },
          ["<leader>w"] = { name = "+windows" },
          ["<leader>x"] = { name = "+diagnostics/quickfix" },
          ["<leader>z"] = { name = "+zen" },
          ["<leader><tab>"] = { name = "+tabs" },
          ["<leader><cr>"] = { name = "+terminal" },
        },
      }
    end,
    opts = {
      plugins = {
        marks = false,
        registers = false,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = false,
          nav = false,
          z = false,
          g = false,
        },
      },
      operators = { gc = "Comments" },
      key_labels = { ["<leader>"] = "SPC" },
      icons = {
        breadcrumb = saturn.icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
        separator = saturn.icons.ui.BoldArrowRight, -- symbol used between a key and it's label
        group = saturn.icons.ui.Plus, -- symbol prepended to a group
      },
      window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
      },
    },

    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(saturn.plugins.which_key.mappings)
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
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
        map("n", "]g", gs.prev_hunk, "Next Git Hunk")
        map("n", "[g", gs.next_hunk, "Prev Git Hunk")
        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "hh", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
    event = { "BufReadPre", "BufNewFile" },
  },

  -- git-conflict
  {
    "akinsho/git-conflict.nvim",
    cmd = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
    },
    config = true,
  },

  -- git blame
  {
    "f-person/git-blame.nvim",
    event = "BufReadPre",
  },

  -- references
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "alpha",
        "NvimTree",
        "lazy",
        "neogitstatus",
        "Trouble",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
      },
      under_cursor = true,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          pcall(vim.keymap.del, "n", "]]", { buffer = buffer })
          pcall(vim.keymap.del, "n", "[[", { buffer = buffer })
        end,
      })
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
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "trouble" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Touble)" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Loclist List (Trouble)" },
      { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", desc = "references" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            vim.cmd.cprev()
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            vim.cmd.cnext()
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
    opts = {
      action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = { "o" }, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "h", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = { "zM", "zm" }, -- close all folds
        open_folds = { "zR", "zr" }, -- open all folds
        toggle_fold = { "zA", "za" }, -- toggle fold of current file
        previous = "i", -- previous item
        next = "e", -- next item
      },
      use_diagnostic_signs = true,
    },
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>rs", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
      { "<leader>rw", function() require('spectre').open_visual({select_word=true}) end, desc = "Replace Word" },
      { "<leader>rf", function() require('spectre').open_file_search() end, desc = "Replace Buffer" },
    },
    config = true,
  },

  -- diffview
  {
    "sindrets/diffview.nvim",
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
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-i>",
        toggle_preview = "I",
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

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    init = function()
      saturn.plugins.dap = {
        on_config_done = nil,
        loaded = false,
      }
    end,
    keys = {
      { "<leader>dd", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
      {
        "<leader>da",
        function()
          vim.ui.input({ prompt = "Condition:" }, function(cond)
            if not cond then
              return
            end
            require("dap").set_breakpoint(nil, nil, cond)
          end)
        end,
        desc = "Set conditonal breakpoint",
        -- expr = true,
      },
      {
        "<leader>dm",
        function()
          vim.ui.input({ prompt = "Log messaeg:" }, function(msg)
            if not msg then
              return
            end
            require("dap").set_breakpoint(nil, nil, msg)
          end)
        end,
        desc = "Set log message breakpoint",
        -- expr = true,
      },
      { "<leader>dl", "<cmd>lua require'dap'.list_breakpoints()<cr>", desc = "List breakpoints" },
      { "<leader>dL", "<cmd>lua require'dap'.clear_breakpoints()<cr>", desc = "Clear breakpoints" },
      { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back" },
      { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
      { "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor" },
      { "<leader>dD", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect" },
      { "<leader>ds", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session" },
      { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
      { "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
      { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
      { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause" },
      { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl" },
      { "<Leader>dR", ":lua require('dap').repl.run_last()<CR>", desc = "Repl Run Last" },
      { "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit" },
      { "<leader>du", "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI" },
      { "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", desc = "Eval" },
      { "<leader>dw", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", desc = "Widget" },
      {
        "<Leader>dW",
        "<cmd>lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>",
        desc = "Center widget",
      },
      { "<Leader>dv", "<cmd>lua require('dap.ui.variables').scopes()<CR>", desc = "Variables Scopes" },
      { "<Leader>dh", "<cmd>lua require('dap.ui.variables').hover()<CR>", desc = "Hover variables" },
      { "<Leader>dh", "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", mode = "v", desc = "Hover variables" },
      { "<F7>", "<leader>di", desc = "Step Into", remap = true },
      { "<S-F7>", "<leader>dO", desc = "Step Out", remap = true },
      { "<F8>", "<leader>do", desc = "Step Over", remap = true },
      { "<S-F8>", "<leader>db", desc = "Step Back", remap = true },
      { "<F9>", "<leader>dC", desc = "Run to Cursor", remap = true },
      { "<F10>", "<leader>dc", desc = "Continue", remap = true },
    },
    opts = {
      breakpoint = {
        text = saturn.icons.ui.Circle,
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      },
      breakpoint_rejected = {
        text = saturn.icons.ui.Bug,
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      },
      stopped = {
        text = saturn.icons.ui.BoldArrowRight,
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
      },
      condition = {
        text = saturn.icons.ui.ExclamationCircle,
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      },
      log_point = {
        text = saturn.icons.ui.InfoCircle,
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      },
      log = {
        level = "info",
      },
    },
    config = function(_, opts)
      local dap = require("dap")

      if saturn.use_icons then
        vim.fn.sign_define("DapBreakpoint", opts.breakpoint)
        vim.fn.sign_define("DapBreakpointRejected", opts.breakpoint_rejected)
        vim.fn.sign_define("DapStopped", opts.stopped)
        vim.fn.sign_define("DapBreakpointCondition", opts.condition)
        vim.fn.sign_define("DapLogPoint", opts.log_point)
      end

      dap.set_log_level(opts.log.level)
      saturn.plugins.dap.loaded = true
      if saturn.plugins.dap.on_config_done then
        saturn.plugins.dap.on_config_done(dap)
      end
    end,
    dependencies = {
      -- Debugger user interface
      {
        "rcarriga/nvim-dap-ui",
        opts = {
          ui = {
            auto_open = true,
            notify = {
              threshold = vim.log.levels.INFO,
            },
            config = {
              icons = { expanded = "", collapsed = "", circular = "" },
              mappings = {
                -- Use a table to apply multiple mappings
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "h",
                repl = "r",
                toggle = "t",
              },
              -- Use this to override mappings for specific elements
              element_mappings = {},
              expand_lines = true,
              layouts = {
                {
                  elements = {
                    { id = "scopes", size = 0.33 },
                    { id = "breakpoints", size = 0.17 },
                    { id = "stacks", size = 0.25 },
                    { id = "watches", size = 0.25 },
                  },
                  size = 0.33,
                  position = "right",
                },
                {
                  elements = {
                    { id = "repl", size = 0.45 },
                    { id = "console", size = 0.55 },
                  },
                  size = 0.27,
                  position = "bottom",
                },
              },
              controls = {
                enabled = true,
                -- Display controls in this element
                element = "repl",
                icons = {
                  pause = "",
                  play = "",
                  step_into = "",
                  step_over = "",
                  step_out = "",
                  step_back = "",
                  run_last = "",
                  terminate = "",
                },
              },
              floating = {
                max_height = 0.9,
                max_width = 0.5, -- Floats will be treated as percentage of your screen.
                border = "rounded",
                mappings = {
                  close = { "q", "<Esc>" },
                },
              },
              windows = { indent = 1 },
              render = {
                max_type_length = nil, -- Can be integer or nil.
                max_value_lines = 100, -- Can be integer or nil.
              },
            },
          },
        },
        config = function(_, opts)
          local dap = require("dap")

          local dapui = require("dapui")
          dapui.setup(opts.ui.config)

          if opts.ui.auto_open then
            dap.listeners.after.event_initialized["dapui_config"] = function()
              dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
              dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
              dapui.close()
            end
          end

          -- until rcarriga/nvim-dap-ui#164 is fixed
          local function notify_handler(msg, level, _opts)
            if level >= opts.ui.notify.threshold then
              return vim.notify(msg, level, _opts)
            end

            _opts = vim.tbl_extend("keep", opts or {}, {
              title = "dap-ui",
              icon = "",
              on_open = function(win)
                vim.api.nvim_buf_set_option(vim.api.nvim_win_get_buf(win), "filetype", "markdown")
              end,
            })

            -- vim_log_level can be omitted
            -- if level == nil then
            --   level = Log.levels["INFO"]
            -- elseif type(level) == "string" then
            --   level = Log.levels[(level):upper()] or Log.levels["INFO"]
            -- else
            --   -- https://github.com/neovim/neovim/blob/685cf398130c61c158401b992a1893c2405cd7d2/runtime/lua/vim/lsp/log.lua#L5
            --   level = level + 1
            -- end

            -- msg = string.format("%s: %s", opts.title, msg)
            -- Log:add_entry(level, msg)
          end

          local dapui_ok, _ = xpcall(function()
            require("dapui.util").notify = notify_handler
          end, debug.traceback)
          if not dapui_ok then
            vim.notify("Unable to override dap-ui logging level")
          end
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
          virt_text_win_col = 80,
          highlight_changed_variables = true,
        },
      },
      {
        "nvim-telescope/telescope-dap.nvim",
        config = function()
          require("telescope").load_extension("dap")
        end,
      },
      { "jbyuki/one-small-step-for-vimkind" },
    },
  },
  {
    "nvim-neotest/neotest",
    keys = {
      {
        "<leader>td",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Debug Nearest",
      },
      {
        "<leader>tt",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run File",
      },
      {
        "<leader>tT",
        function()
          require("neotest").run.run(vim.loop.cwd())
        end,
        desc = "Run All Test Files",
      },
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle Summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "Show Output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Output Panel",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop",
      },
    },
    opts = {
      -- Can be a list of adapters like what neotest expects,
      -- or a table of adapter names, mapped to adapter configs.
      -- The adapter will then be automatically loaded with the config.
      adapters = {},
      -- Example for loading neotest-go with a custom config
      -- adapters = {
      --   ["neotest-go"] = {
      --     args = { "-tags=integration" },
      --   },
      -- },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              adapter = adapter(config)
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    cmd = "BqfAutoToggle",
  },

  { import = "saturn.plugins.extra.ufo" },
  { import = "saturn.plugins.extra.flatten" },
  -- { import = "saturn.plugins.extra.nvim-navbuddy" },
}