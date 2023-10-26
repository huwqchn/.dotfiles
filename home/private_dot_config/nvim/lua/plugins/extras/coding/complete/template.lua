return {
  {
    "nvimdev/template.nvim",
    cmd = "Template",
    config = function()
      require("template").setup({
        temp_dir = "~/.config/nvim/template",
        author = "johnson",
        email = "huwqchn@gmali.com",
      })
      require("telescope").load_extension("find_template")
    end,
  },
}
