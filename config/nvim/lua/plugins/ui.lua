local function isGui()
  return vim.g.neovide or vim.g.goneovim or vim.g.started_by_firenvim
end

return {
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      scope = {
        enabled = false,
      },
    },
  },
  {
    "Bekaboo/dropbar.nvim",
    keys = {
      {
        "sp",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Select dropbar",
      },
    },
    opts = function()
      local menu_utils = require("dropbar.utils.menu")

      -- Closes all the windows in the current dropbar.
      local function close()
        local menu = menu_utils.get_current()
        while menu and menu.prev_menu do
          menu = menu.prev_menu
        end
        if menu then
          menu:close()
        end
      end

      return {
        menu = {
          keymaps = {
            -- Navigate back to the parent menu.
            ["n"] = "<C-w>q",
            -- Expands the entry if possible.
            ["o"] = function()
              local menu = menu_utils.get_current()
              if not menu then
                return
              end
              local row = vim.api.nvim_win_get_cursor(menu.win)[1]
              local component = menu.entries[row]:first_clickable()
              if component then
                menu:click_on(component, nil, 1, "l")
              end
            end,
            ["O"] = function()
              local menu = menu_utils.get_current()
              if not menu then
                return
              end
              menu:fuzzy_find_open()
            end,
            ["i"] = "k", -- don't use i for fuzzy search, use O instead
            ["q"] = close,
            ["<esc>"] = close,
          },
        },
      }
    end,
    event = "VeryLazy",
  },
  {
    "akinsho/bufferline.nvim",
    cond = not vim.g.started_by_firenvim,
    dependencies = {
      {
        "tiagovla/scope.nvim",
        config = true,
      },
    },
    keys = {
      -- { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next" },
      -- { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous" },
      { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Jump" },
      { "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Pick Close" },
      { "<leader>bn", "<cmd>BufferLineMoveLeft<cr>", desc = "Move left" },
      { "<leader>bo", "<cmd>BufferLineMoveRight<cr>", desc = "Move right" },
      { "<leader>bN", "<cmd>BufferLineCloseLeft<cr>", desc = "Close all to the left" },
      { "<leader>bO", "<cmd>BufferLineCloseRight<cr>", desc = "Close all to the right" },
      { "<leader>bD", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort by directory" },
      { "<leader>bL", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort by language" },
    },
    opts = {
      highlights = {
        background = {
          italic = true,
        },
        buffer_selected = {
          bold = true,
        },
      },
      options = {
        indicator = {
          style = "underline", -- can also be 'underline'|'none',
        },
        name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
          -- remove extension from markdown files for example
          if buf.name:match("%.md") then
            return vim.fn.fnamemodify(buf.name, ":t:r")
          end
        end,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
      },
    },
  },
  {
    "folke/noice.nvim",
    cond = not isGui(),
    opts = function(_, opts)
      opts.lsp.progress = {
        enabled = false,
      }
      table.insert(opts.routes, 1, {
        filter = {
          event = "msg_show",
          find = "%d+L, %d+B",
        },
        view = "mini",
      })
      table.insert(opts.routes, 1, {
        filter = {
          find = "offset_encodings",
        },
        opts = { skip = true },
      })
      table.insert(opts.routes, 1, {
        filter = {
          find = "character_offset",
        },
        opts = { skip = true },
      })
      table.insert(opts.routes, 1, {
        filter = {
          find = "method textDocument",
        },
        opts = { skip = true },
      })
      table.insert(opts.routes, 1, {
        filter = {
          find = "cmp_tabnine/source.lua:280",
        },
        opts = { skip = true },
      })
      table.insert(opts.routes, 1, {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      })
      opts.presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        cmdline_output_to_split = false,
        lsp_doc_border = true,
      }
      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }
      opts.format = {
        level = {
          icons = false,
        },
      }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<bs>",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      background_colour = "#000000",
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    build = "./kitty/install-kittens.bash",
    lazy = false,
    keys = {
      { "<leader>wr", "<Cmd>SmartResizeMode<CR>", mode = "n", desc = "Resize mode" },
      -- resizing splits
      {
        mode = { "n", "t" },
        "<C-Left>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "resize left",
      },
      {
        mode = { "n", "t" },
        "<C-Down>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "resize down",
      },
      {
        mode = { "n", "t" },
        "<C-Up>",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "resize up",
      },
      {
        mode = { "n", "t" },
        "<C-Right>",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "resize right",
      },
      -- moving between splits
      {
        mode = { "n", "t" },
        "<C-n>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "move cursor left",
      },
      {
        mode = { "n", "t" },
        "<C-e>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "move cursor down",
      },
      {
        mode = { "n", "t" },
        "<C-i>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "move cursor up",
      },
      {
        mode = { "n", "t" },
        "<C-o>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "move cursor right",
      },
      -- swapping buffers between windows
      {
        mode = { "n", "t" },
        "sN",
        function()
          require("smart-splits").swap_buf_left()
        end,
        desc = "swap buffer left",
      },
      {
        mode = { "n", "t" },
        "sE",
        function()
          require("smart-splits").swap_buf_down()
        end,
        desc = "swap buffer down",
      },
      {
        mode = { "n", "t" },
        "sI",
        function()
          require("smart-splits").swap_buf_up()
        end,
        desc = "swap buffer up",
      },
      {
        mode = { "n", "t" },
        "sO",
        function()
          require("smart-splits").swap_buf_right()
        end,
        desc = "swap buffer right",
      },
    },
    opts = {
      -- Ignored filetypes (only while resizing)
      ignored_filetypes = {
        "nofile",
        "quickfix",
        "prompt",
        "qf",
      },
      -- Ignored buffer types (only while resizing)
      ignored_buftypes = { "NvimTree", "neo-tree" },
      -- the default number of lines/columns to resize by at a time
      default_amount = 3,
      -- when moving cursor between splits left or right,
      -- place the cursor on the same row of the *screen*
      -- regardless of line numbers. False by default.
      -- Can be overridden via function parameter, see Usage.
      move_cursor_same_row = false,
      -- resize mode options
      resize_mode = {
        -- key to exit persistent resize mode
        quit_key = "<ESC>",
        -- keys to use for moving in resize mode
        -- in order of left, down, up' right
        resize_keys = { "n", "e", "i", "o" },
        -- set to true to silence the notifications
        -- when entering/exiting persistent resize mode
        silent = false,
        -- must be functions, they will be executed when
        -- entering or exiting the resize mode
        hooks = {
          on_enter = function()
            vim.notify("Entering resize mode")
          end,
          on_leave = function()
            vim.notify("Exiting resize mode, bye")
            -- require("bufresize").register()
          end,
        },
      },
      -- ignore these autocmd events (via :h eventignore) while processing
      -- smart-splits.nvim computations, which involve visiting different
      -- buffers and windows. These events will be ignored during processing,
      -- and un-ignored on completed. This only applies to resize events,
      -- not cursor movement events.
      ignored_events = {
        "BufEnter",
        "WinEnter",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local sep = {
        left = opts.icons.SeparatorLeft,
        right = opts.icons.SeparatorRight,
      }
      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir - 5 <= #filepath
        end,
        check_lsp_active = function()
          local ok, clients = pcall(LazyVim.lsp.get_clients, { bufnr = 0 })
          if not ok or #clients == 1 and clients[1].name == "copilot" then
            return false
          end
          return ok and #clients > 0
        end,
      }
      -- local space = {
      --   function()
      --     return " "
      --   end,
      --   color = { bg = "none" },
      -- }
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
      opts.sections.lualine_a = {
        {
          "mode",
          fmt = function(str)
            return str:sub(1, 1)
          end,
          separator = sep,
        },
      }
      opts.sections.lualine_b = {
        {
          function()
            return opts.icons.Saturn
          end,
          separator = sep,
        },
        {
          function()
            return " "
          end,
          color = { bg = "none" },
          cond = conditions.check_git_workspace,
        },
        {
          "branch",
          icon = opts.icons.GitBranch,
          color = { bg = Snacks.util.color("Operator"), fg = Snacks.util.color("Cursor") },
          separator = sep,
        },
        {
          "diff",
          symbols = {
            added = opts.icons.GitLineAdded .. " ",
            modified = opts.icons.GitLineModified .. " ",
            removed = opts.icons.GitLineRemoved .. " ",
          },
          padding = { left = 2, right = 1 },
          separator = sep,
        },
      }
      opts.sections.lualine_y = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = {
            error = opts.icons.DiagError .. " ",
            warn = opts.icons.DiagWarning .. " ",
            info = opts.icons.DiagInformation .. " ",
            hint = opts.icons.DiagHint .. " ",
          },
          separator = sep,
        },
        {
          function()
            local clients = LazyVim.lsp.get_clients()
            return opts.icons.LspPrefix .. clients[1].name
          end,

          cond = conditions.check_lsp_active,
          separator = sep,
          color = { bg = Snacks.util.color("Substitute", "bg"), fg = Snacks.util.color("Cursor") },
        },
        {
          function()
            return " "
          end,
          color = { bg = "none" },
          cond = conditions.check_lsp_active,
        },
        {
          "fileformat",
          separator = sep,
        },
      }
      opts.sections.lualine_z = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", separator = sep, padding = { left = 0, right = 0 } },
      }
      -- remove lazyvim diff
      table.remove(opts.sections.lualine_x, #opts.sections.lualine_x)
      -- remove lazyvim symbols
      table.remove(opts.sections.lualine_c, #opts.sections.lualine_c)
      -- remove padding of path
      opts.sections.lualine_c[4].padding = { left = 0, right = 0 }
      -- remove lazyvim diagnostics
      table.remove(opts.sections.lualine_c, 2)
    end,
  },
}
