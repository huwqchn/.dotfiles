return {
  --TODO: need to refactor this
  -- { import = "plugins.extras.ui.bar.lualine" },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local sep = {
        left = opts.icons.SeparatorLeft,
        right = opts.icons.SeparatorRight,
      }
      local space = {
        function()
          return " "
        end,
        color = { bg = "none" },
      }
      opts.options.theme = opts.theme
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
        space,
        {
          "branch",
          icon = opts.icons.GitBranch,
          color = { bg = opts.colors.green, fg = opts.colors.grey },
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
        space,
      }
      for i = 1, #opts.sections.lualine_c do
        opts.sections.lualine_c[i].separator = sep
      end

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

          cond = function()
            local ok, clients = pcall(require("lazyvim.util").lsp.get_clients, { bufnr = 0 })
            if not ok then
              return false
            end
            return ok and #clients > 0
          end,
          separator = sep,
          color = { bg = opts.colors.pink, fg = opts.colors.grey },
        },
        space,
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
