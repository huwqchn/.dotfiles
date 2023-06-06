return {
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    config = function()
      local function get_diagnostic_label(props)
        local icons = { error = "", warn = "", info = "", hint = "" }
        local label = {}

        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then
            table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
          end
        end
        if #label > 0 then
          table.insert(label, { "| " })
        end
        return label
      end
      local function get_git_diff(props)
        local icons = { removed = "", changed = "", added = "" }
        local labels = {}
        local signs = vim.api.nvim_buf_get_var(props.buf, "gitsigns_status_dict")
        -- local signs = vim.b.gitsigns_status_dict
        for name, icon in pairs(icons) do
          if tonumber(signs[name]) and signs[name] > 0 then
            table.insert(labels, { icon .. " " .. signs[name] .. " ", group = "Diff" .. name })
          end
        end
        if #labels > 0 then
          table.insert(labels, { "| " })
        end
        return labels
      end
      -- local colors = require("tokyonight.colors").setup()
      require("incline").setup({
        -- highlight = {
        --   groups = {
        --     InclineNormal = { guibg = "#FC56B1", guifg = colors.black },
        --     InclineNormalNC = { guifg = "#FC56B1", guibg = colors.black },
        --   },
        -- },
        window = { margin = { vertical = 0, horizontal = 1 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
          local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "bold,italic" or "bold"
          local count = vim.fn.searchcount({ recompute = 1, maxcount = -1 })
          local contents = vim.fn.getreg("/")
          if string.len(contents) == 0 then
            return ""
          end

          local buffer = {
            { get_diagnostic_label(props) },
            { get_git_diff(props) },
            { ft_icon, guifg = ft_color },
            { " " },
            { filename, gui = modified },
            {
              " ? ",
              group = "dkoStatusKey",
            },
            {
              (" %s "):format(contents),
              group = "IncSearch",
            },
            {
              (" %d/%d "):format(count.current, count.total),
              group = "dkoStatusValue",
            },
          }
          return buffer
        end,
      })
    end,
  },
}
