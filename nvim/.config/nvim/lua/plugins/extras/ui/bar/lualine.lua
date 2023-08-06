return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    cond = not vim.g.started_by_firenvim, -- not load when start by firenvim
    opts = function(_, opts)
      local colors = opts.colors
      local icons = opts.icons
      -- auto change color according to neovims mode
      local mode_color = {
        n = colors.cyan,
        i = colors.yellow,
        v = colors.purple,
        [""] = colors.purple,
        V = colors.purple,
        c = colors.pink,
        no = colors.pink,
        s = colors.green,
        S = colors.green,
        [""] = colors.green,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.teal,
        rm = colors.teal,
        ["r?"] = colors.teal,
        ["!"] = colors.white,
        t = colors.white,
      }

      local function mode_color_fn()
        return { bg = mode_color[vim.fn.mode()], fg = colors.black }
      end

      local window_width_limit = 100

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.o.columns > window_width_limit
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
        has_noice_command = function()
          return package.loaded["noice"] and require("noice").api.status.command.has()
        end,
        lsp_active = function()
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return false
          end
          return true
        end,
      }

      local vim_icon = {
        function()
          return icons.Saturn
        end,
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
        color = { bg = colors.grey, fg = colors.blue },
      }

      local space = {
        function()
          return " "
        end,
        color = { bg = colors.background, fg = colors.blue },
      }

      local filename = {
        "filename",
        color = { bg = colors.blue, fg = colors.grey },
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
        cond = conditions.hide_in_width,
      }

      local filetype = {
        "filetype",
        icon_only = true,
        colored = true,
        color = { bg = colors.grey },
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
      }

      local fileformat = {
        "fileformat",
        color = { bg = colors.white, fg = colors.grey },
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
      }

      local encoding = {
        "encoding",
        color = { bg = colors.grey, fg = colors.blue },
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
      }

      local branch = {
        "branch",
        icon = icons.GitBranch,
        color = { bg = colors.green, fg = colors.grey },
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
      }

      local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end

      local diff = {
        "diff",
        source = diff_source,
        symbols = {
          added = icons.GitLineAdded .. " ",
          modified = icons.GitLineModified .. " ",
          removed = icons.GitLineRemoved .. " ",
        },
        padding = { left = 2, right = 1 },
        color = { bg = colors.grey, fg = colors.grey },
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
      }

      local modes = {
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end,
        color = mode_color_fn,
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
      }

      local function getLspName()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
            return icons.LspPrefix .. " " .. client.name
          end
        end
        return icons.LspPrefix .. " " .. msg
      end

      local dia = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = icons.DiagError .. " ",
          warn = icons.DiagWarning .. " ",
          info = icons.DiagInformation .. " ",
          hint = icons.DiagHint .. " ",
        },
        color = { bg = colors.grey, fg = colors.blue },
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
      }

      local lsp = {
        function()
          return getLspName()
        end,
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
        color = { bg = colors.red, fg = colors.black },
        cond = conditions.lsp_active,
      }

      local lazy = {
        require("lazy.status").updates,
        cond = require("lazy.status").has_updates,
        color = { bg = colors.voilet, fg = colors.grey },
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
      }

      local lazy_space = {
        function()
          return " "
        end,
        color = { bg = colors.background, fg = colors.blue },
        cond = require("lazy.status").has_updates,
      }

      local key = {
        function()
          return require("noice").api.status.command.get()
        end,
        cond = conditions.has_noice_command,
        color = { bg = colors.grey, fg = colors.purple },
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
      }

      local key_icon = {
        function()
          return icons.Keyboard
        end,
        cond = conditions.has_noice_command,
        color = { bg = colors.purple, fg = colors.grey },
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
      }

      local lsp_space = {
        function()
          return " "
        end,
        color = { bg = colors.background, fg = colors.blue },
        cond = conditions.lsp_active,
      }

      local debug_mode = {
        function()
          if package.loaded["dap"] then
            return require("dap").status()
          end
          return ""
        end,
        color = { bg = colors.red, fg = colors.black },
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
        cond = conditions.hide_in_width,
      }

      local breakpoint_count = {
        function()
          if package.loaded["dap"] then
            local breakpoints = require("dap.breakpoints").get()
            local breakpointSum = 0
            for buf, _ in pairs(breakpoints) do
              breakpointSum = breakpointSum + #breakpoints[buf]
            end
            if breakpointSum == 0 then
              return ""
            end
            return icons.Bug .. " " .. tostring(breakpointSum)
          end
          return ""
        end,
        color = { bg = colors.grey, fg = colors.red },
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
        cond = conditions.hide_in_width,
      }

      -- local macros = {
      --   function()
      --     if package.loaded["NeoComposer"] then
      --       return require("NeoComposer.ui").status_recording()
      --     end
      --     return ""
      --   end,
      --   cond = conditions.hide_in_width,
      -- }

      local function env_cleanup(venv)
        if string.find(venv, "/") then
          local final_venv = venv
          for w in venv:gmatch("([^/]+)") do
            final_venv = w
          end
          venv = final_venv
        end
        return venv
      end

      local python_env = {
        function()
          if vim.bo.filetype == "python" then
            local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
            if venv then
              -- local icons = require("nvim-web-devicons")
              -- local py_icon, _ = icons.get_icon(".py")
              return string.format("%s", env_cleanup(venv))
            end
          end
          return ""
        end,
        color = { bg = colors.teal, fg = colors.grey },
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
        cond = conditions.hide_in_width,
      }

      local python_env_icon = {
        function()
          if vim.bo.filetype == "python" then
            local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
            if venv then
              return require("nvim-web-devicons").get_icon(".py")
            end
          end
          return ""
        end,
        color = { bg = colors.grey, fg = colors.teal },
        separator = { left = icons.SeparatorLeft, right = icons.SeparatorRight },
        cond = conditions.hide_in_width,
      }

      local hide_in_width_space = {
        function()
          return " "
        end,
        color = { bg = colors.background, fg = colors.blue },
        cond = conditions.hide_in_width,
      }

      return {
        options = {
          icons_enabled = true,
          theme = opts.theme,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },

        sections = {
          lualine_a = {
            --{ 'mode', fmt = function(str) return str:gsub(str, "  ") end },
            modes,
            vim_icon,
            --{ 'mode', fmt = function(str) return str:sub(1, 1) end },
          },
          lualine_b = {
            space,
            filename,
            filetype,
            space,
          },
          lualine_c = {
            branch,
            diff,
            hide_in_width_space,
            debug_mode,
            breakpoint_count,
            hide_in_width_space,
            python_env,
            python_env_icon,
          },
          lualine_x = {
            lazy,
            lazy_space,
            -- macros,
            key,
            key_icon,
            space,
          },
          lualine_y = {
            encoding,
            fileformat,
          },
          lualine_z = {
            lsp_space,
            dia,
            lsp,
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
      }
    end,
  },
}
