return {
  {
    "nvim-cmp",
    dependencies = {
      {
        "jcdickinson/codeium.nvim",
        dependencies = {
          {
            "jcdickinson/http.nvim",
            build = "cargo build --workspace --release",
          },
        },
        config = true,
      },
    },
    opts = function(_, opts)
      table.insert(opts.sources, 1, { name = "codeium", group_index = 2 })
    end,
  },
}
