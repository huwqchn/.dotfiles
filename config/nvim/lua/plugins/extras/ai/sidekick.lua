return {
  {
    import = "lazyvim.plugins.extras.ai.sidekick",
  },
  {
    "folke/sidekick.nvim",
    keys = {
      {
        "<leader>ac",
        function()
          require("sidekick.cli").toggle({ name = "cursor", focus = true })
        end,
        desc = "Sidekick Cursor Toggle",
        mode = { "n", "v" },
      },
    },
    opts = {
      debug = false,
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
  },
}
