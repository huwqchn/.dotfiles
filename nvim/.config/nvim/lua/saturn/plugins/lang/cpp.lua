return {
  -- {
  --   "sakhnik/nvim-gdb",
  --   build = "./install.sh",
  -- },
  {
    "p00f/clangd_extensions.nvim",
    ft = "cpp",
    opts = {
      autoSetHints = false,
      memory_usage = {
        border = "rounded",
      },
      symbol_info = {
        border = "rounded",
      },
    },
  },
}
