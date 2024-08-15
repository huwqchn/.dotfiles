-- default jump
return {
  { import = "lazyvim.plugins..extras.editor.leap" },
  {
    "ggandor/leap.nvim",
    optional = true,
    keys = function()
      return {
        {
          "<leader>j",
          "<cmd>lua require('leap').leap { target_windows = { vim.fn.win_getid() } }<cr>",
          desc = "jump",
          mode = { "n", "x" },
        },
        {
          "<leader>J",
          "<cmd>lua require('leap').leap { target_windows = vim.tbl_filter(function (win) return vim.api.nvim_win_get_config(win).focusable end,vim.api.nvim_tabpage_list_wins(0))}<cr>",
          desc = "jump to any window",
          mode = { "n", "x" },
        },
        { ";", "<Plug>(leap-forward-to)", desc = "leap forward to", mode = { "n", "x", "o" } },
        { ":", "<Plug>(leap-backward-to)", desc = "leap backward to", mode = { "n", "x", "o" } },
        { "s,", "<Plug>(leap-cross-window)", desc = "leap cross window", mode = { "n", "x", "o" } },
        { "x", "<Plug>(leap-forward-till)", desc = "leap forward till", mode = { "x", "o" } },
        { "X", "<Plug>(leap-backward-till)", desc = "leap backward till", mode = { "x", "o" } },
      }
    end,
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
    end,
  },
  {
    "ggandor/flit.nvim",
    opts = { labeled_modes = "nxo" },
  },
}
