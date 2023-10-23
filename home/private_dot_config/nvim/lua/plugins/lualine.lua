return {
  -- { import = "plugins.extras.ui.bar.lualine" },
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
          return gitdir and #gitdir > 0 and #gitdir - 4 < #filepath
          -- why need -4, bec path + /.git sometime > path + dir(dirname < 4)
        end,
        check_lsp_active = function()
          local ok, clients = pcall(require("lazyvim.util").lsp.get_clients, { bufnr = 0 })
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
      local Util = require("lazyvim.util")
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
          color = { bg = Util.ui.fg("Operator").fg, fg = Util.ui.fg("Cursor").fg },
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
            local clients = require("lazyvim.util").lsp.get_clients()
            return opts.icons.LspPrefix .. clients[1].name
          end,

          cond = conditions.check_lsp_active,
          separator = sep,
          color = { bg = Util.ui.fg("TSRainbowRed").fg, fg = Util.ui.fg("Cursor").fg },
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
      table.remove(opts.sections.lualine_x, #opts.sections.lualine_x)
      table.remove(opts.sections.lualine_c, #opts.sections.lualine_c)
      table.remove(opts.sections.lualine_c, 2)
    end,
  },
}
