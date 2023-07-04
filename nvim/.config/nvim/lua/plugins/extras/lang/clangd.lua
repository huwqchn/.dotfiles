return {
  {
    "Civitasv/cmake-tools.nvim",
    opts = {},
    cmd = {
      "CMakeGenerate",
      "CMakeBuild",
      "CMakeRun",
      "CMakeDebug",
      "CMakeLaunchArgs",
      "CMakeSelectBuildType",
      "CMakeSelectLaunchTarget",
      "CMakeSelectKit",
      "CMakeSelectConfigurePreset",
      "CMakeSelectBuildPreset",
      "CMakeOpen",
      "CMakeClose",
      "CMakeInstall",
      "CMakeClean",
      "CMakeStop",
    },
  },
  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        clangd = {
          keys = {
            { "s<space>", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
        },
      },
    },
  },
}
