return {
  {
    "3rd/image.nvim",
    enabled = not vim.g.neovide,
    ft = { "markdown", "vimwiki", "quarto", "python" },
    opts = {
      {
        integrations = {
          markdown = { filetypes = { "markdown", "vimwiki", "quarto", "python" } },
        },
        max_width = 100,
        max_height = 12,
        max_height_window_percentage = math.huge, -- this is necessary for a good experience
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      },
    },
  },
}
