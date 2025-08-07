return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        keymaps = {
          toggle_package_expand = "<Space>",
          install_package = "<CR>",
          check_package_version = "c",
          check_outdated_packages = "C",
          uninstall_package = "X",
          cancel_installation = "<C-c>",
          apply_language_filter = "<C-f>",
        },
      },
    },
  },
}
