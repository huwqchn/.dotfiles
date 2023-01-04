local M = {
  "romgrk/searchbox.nvim",
  dependencies = {
    { "MunifTanjim/nui.nvim" },
  },
  keys = {
    { "/", ":SearchBoxIncSearch<CR>", mode = "n", noremap = true },
    { "/", ":SearchBoxIncSearch visual_mode=true<CR>", mode = "x", noremap = true },
  },
}

M.config = function()
  require("searchbox").setup({
    icons = {
      search = " ",
      case_sensitive = " ",
      pattern = " ",
      fuzzy = " ",
    },
    popup = {
      relative = "win",
      position = {
        row = "5%",
        col = "95%",
      },
      size = 30,
      border = {
        style = "rounded",
        highlight = "FloatBorder",
        text = {
          top = " Search ",
          top_align = "left",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal",
      },
    },
    hooks = {
      before_mount = function(input)
        -- code
      end,
      after_mount = function(input)
        -- code
      end,
      on_done = function(value, search_type)
        -- code
      end,
    },
  })
end

return M
