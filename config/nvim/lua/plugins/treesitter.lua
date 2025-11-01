return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      indent = { enable = true, disable = { "yaml", "python", "css", "c", "cpp" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "ss",
          node_incremental = "ss",
          node_decremental = "sS",
          scope_incremental = "so",
        },
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    },
  },
}
