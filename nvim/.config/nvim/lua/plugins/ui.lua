return {
  --TODO: need to refactor this
  -- { import = "plugins.extras.ui.bar.lualine" },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.remove(opts.sections.lualine_c, #opts.sections.lualine_c)
      vim.tbl_extend("force", opts, {
        options = {
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
      })
    end,
  },
}
