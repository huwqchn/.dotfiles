return {
  "telescope.nvim",
  dependencies = {
    {
      "nvimdev/template.nvim",
      cmd = { "Template", "TemProject" },
      opts = {
        temp_dir = "~/.config/nvim/template",
        author = "Johnson Hu",
        email = "huwqchn@gmail.com",
      },
      config = function(_, opts)
        require("template").setup(opts)
        require("lazyvim.util").on_load("telescope.nvim", function()
          require("telescope").load_extension("find_template")
        end)
      end,
    },
  },
  keys = {
    { "<leader>fN", "<cmd>Telescope find_template type=insert<cr>", desc = "New file from template" },
  },
}
