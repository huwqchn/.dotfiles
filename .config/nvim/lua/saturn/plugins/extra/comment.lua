return {
  {
    "echasnovski/mini.comment",
    enabled = false,
  },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc" },
      { "gbc" },
      { "gcO" },
      { "gco" },
      { "gcA" },
      { "gc", mode = { "x", "o" } },
      { "gb", mode = { "x", "o" } },
      {
        "<leader>/",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        mode = "n",
        desc = "Comment",
      },
      {
        "<leader>/",
        "<Plug>(comment_toggle_linewise_visual)",
        mode = "v",
        desc = "Comment toggle linewise (visual)",
      },
    },
    opts = {
      pre_hook = function()
        require("ts_context_commentstring.internal").update_commentstring({})
      end,
    },
  },
}
