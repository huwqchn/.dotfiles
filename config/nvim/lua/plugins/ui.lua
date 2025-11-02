return {
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      scope = {
        enabled = false,
      },
      zen = {
        win = {
          wo = {
            number = false,
            relativenumber = false,
            colorcolumn = "",
            signcolumn = "no",
            statuscolumn = "",
            winbar = "",
            cursorline = false,
          },
        },
        on_open = function()
          -- disable snacks indent
          Snacks.indent.disable()
          vim.cmd("GitBlameDisable")
        end,
        on_close = function()
          -- restore snacks indent setting
          Snacks.indent.enable()
          vim.cmd("GitBlameEnable")
        end,
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
            ["h"] = "<C-w>q",
            -- Expands the entry if possible.
            ["l"] = function()
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
            ["L"] = function()
              local menu = menu_utils.get_current()
              if not menu then
                return
              end
              menu:fuzzy_find_open()
            end,
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
    optional = true,
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
      { "<leader>b[", "<cmd>BufferLineMoveLeft<cr>", desc = "Move left" },
      { "<leader>b]", "<cmd>BufferLineMoveRight<cr>", desc = "Move right" },
      { "<leader>b{", "<cmd>BufferLineCloseLeft<cr>", desc = "Close all to the left" },
      { "<leader>b}", "<cmd>BufferLineCloseRight<cr>", desc = "Close all to the right" },
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
    "nvim-lualine/lualine.nvim",
    optional = true,
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
          local ok, clients = pcall(vim.lsp.get_clients, { bufnr = 0 })
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
            local clients = vim.lsp.get_clients()
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
