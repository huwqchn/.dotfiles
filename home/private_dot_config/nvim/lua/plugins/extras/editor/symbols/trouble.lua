return {
  {
    "folke/trouble.nvim",
    optional = true,
    opts = {
      keys = {
        I = "inspect",
        e = "next",
        i = "prev",
      },
      modes = {
        cascade = {
          mode = "diagnostics", -- inherit from diagnostics mode
          focus = true,
          filter = function(items)
            local severity = vim.diagnostic.severity.HINT
            for _, item in ipairs(items) do
              severity = math.min(severity, item.severity)
            end
            return vim.tbl_filter(function(item)
              return item.severity == severity
            end, items)
          end,
        },
      },
    },
  },
}
