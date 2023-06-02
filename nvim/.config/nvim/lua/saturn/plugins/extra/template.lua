return {
  {
    "glepnir/template.nvim",
    cmd = { "Template", "TemProject" },
    config = function()
      require("template").setup({
        temp_dir = "~/.config/nvim/template",
        author = "Johnson Hu",
        email = "huwqchn@gmail.com",
      })
      require("telescope").load_extension("find_template")
    end,
  },
}
