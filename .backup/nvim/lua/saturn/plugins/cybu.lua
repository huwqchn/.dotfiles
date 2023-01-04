local M = {
  "ghillb/cybu.nvim",
  branch = "main", -- timely updates
  -- branch = "v1.x", -- won't receive breaking changes
  dependencies = {
    "nvim-web-devicons",
    "plenary.nvim",
  }, -- optional for icon support
  enabled = saturn.enable_extra_plugins,
}

function M.init()
  saturn.plugins.cybu = {
    position = {
      relative_to = "win", -- win, editor, cursor
      anchor = "topright", -- topleft, topcenter, topright,
      -- centerleft, center, centerright,
      -- bottomleft, bottomcenter, bottomright
      -- vertical_offset = 10, -- vertical offset from anchor in lines
      -- horizontal_offset = 0, -- vertical offset from anchor in columns
      -- max_win_height = 5, -- height of cybu window in lines
      -- max_win_width = 0.5, -- integer for absolute in columns
      -- float for relative to win/editor width
    },
    display_time = 1750, -- time the cybu window is displayed
    style = {
      path = "relative", -- absolute, relative, tail (filename only)
      border = "rounded", -- single, double, rounded, none
      separator = " ", -- string used as separator
      prefix = "…", -- string used as prefix for truncated paths
      padding = 1, -- left & right padding in number of spaces
      hide_buffer_id = true,
      devicons = {
        enabled = true, -- enable or disable web dev icons
        colored = true, -- enable color for web dev icons
      },
    },
  }
  if saturn.plugins.cybu.active then
    saturn.plugins.whichkey.mappings["u"]["n"] = { "<Plug>(CybuPrev)", "Move Previous Buffer" }
    saturn.plugins.whichkey.mappings["u"]["i"] = { "<Plug>(CybuNext)", "Move Next Buffer" }
  end
end

function M.config()
  require("cybu").setup(saturn.plugins.cybu)

  vim.keymap.set("n", "<s-tab>", "<plug>(CybuLastusedPrev)")
  vim.keymap.set("n", "<tab>", "<plug>(CybuLastusedNext)")
end

return M
