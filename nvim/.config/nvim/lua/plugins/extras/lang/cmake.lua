return {

  -- Add CMake to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "cmake" })
      end
    end,
  },

  -- Add CMake Tools
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
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

  -- Correctly setup lspconfig for CMake 🚀
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       -- Ensure mason installs the server
  --       neocmake = {},
  --     },
  --     settings = {
  --       neocmake = {},
  --     },
  --   },
  -- },
}
