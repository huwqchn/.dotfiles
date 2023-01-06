local M = {
  "Saecki/crates.nvim",
  version = "v0.3.0",
  dependencies = { "plenary.nvim" },
  ft = { "rust", "toml" },
  config = {
    popup = {
      -- autofocus = true,
      style = "minimal",
      border = "rounded",
      show_version_date = false,
      show_dependency_version = true,
      max_height = 30,
      min_width = 20,
      padding = 1,
    },
    null_ls = {
      enabled = true,
      name = "crates.nvim",
    },
  },
}

return M
