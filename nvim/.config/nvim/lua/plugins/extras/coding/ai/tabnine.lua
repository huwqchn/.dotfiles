return {
  {
    "nvim-cmp",
    dependencies = {
      {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
        opts = {
          max_lines = 1000,
          max_num_results = 20,
          sort = true,
          run_on_every_keystroke = true,
          snippet_placeholder = "..",
          ignored_file_types = { -- default is not to ignore
            -- uncomment to ignore in lua:
            -- lua = true
          },
          show_prediction_strength = true,
        },
      },
    },
    opts = function(_, opts)
      table.insert(opts.sources, 1, { name = "cmp_tabnine", group_index = 2 })
    end,
  },
}
