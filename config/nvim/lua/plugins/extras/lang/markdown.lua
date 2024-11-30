return {
  { import = "lazyvim.plugins.extras.lang.markdown" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "vimwiki", "norg", "rmd", "org" },
    opts = function()
      return {
        file_types = { "markdown", "norg", "rmd", "org" },
      }
    end,
  },
  -- {
  --   "3rd/image.nvim",
  --   enabled = not vim.g.neovide,
  --   ft = { "markdown", "vimwiki", "quarto", "python" },
  --   opts = {
  --     tmux_show_only_in_active_window = true,
  --     integrations = {
  --       markdown = {
  --         only_render_image_at_cursor = true,
  --         only_render_image_at_cursor_mode = "popup",
  --         filetypes = { "markdown", "vimwiki", "quarto", "python" },
  --       },
  --     },
  --     hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif", "*.svg" },
  --   },
  -- },
}
