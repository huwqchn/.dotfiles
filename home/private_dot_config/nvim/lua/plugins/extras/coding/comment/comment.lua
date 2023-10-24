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
        "<c-/>",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        mode = "n",
        desc = "Comment",
      },
      {
        "<c-/>",
        "<Plug>(comment_toggle_linewise_visual)",
        mode = "x",
        desc = "Comment toggle linewise (visual)",
      },
      -- { "<c-_>", "<c-/>", mode = "x", remap = true },
      -- { "<c-_>", "<c-/>", mode = "x", remap = true },
    },
    opts = {
      pre_hook = function(...)
        local loaded, ts_comment = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
        if loaded and ts_comment then
          return ts_comment.create_pre_hook()(...)
        end
      end,
    },
  },
}
