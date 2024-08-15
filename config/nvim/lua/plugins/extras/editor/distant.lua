return {
  {
    "chipsenkbeil/distant.nvim.git",
    branch = "v0.2",
    cmd = {
      "DistantLauch",
      "DistantOpen",
      "DistantConnect",
      "DistantInstall",
      "DistantMetadata",
      "DistantShell",
      "DistantSessionInfo",
      "DistantSystemInfo",
      "DistantClientVersion",
      "DistantCopy",
      "DistantMkdir",
      "DistantRemove",
      "DistantRename",
      "DistantRun",
      "DistantSearch",
    },
    config = function()
      require("distant").setup({
        -- Applies Chip's personal settings to every machine you connect to
        --
        -- 1. Ensures that distant servers terminate with no connections
        -- 2. Provides navigation bindings for remote directories
        -- 3. Provides keybinding to jump into a remote file's parent directory
        ["*"] = require("distant.settings").chip_default(),
      })
    end,
  },
}
