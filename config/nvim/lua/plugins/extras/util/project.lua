return {
  { import = "lazyvim.plugins.extras.util.project" },
  {
    "ahmedkhalf/project.nvim",
    optional = true,
    event = function()
      return {}
    end,
  },
}
