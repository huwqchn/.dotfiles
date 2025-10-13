return {
  { import = "lazyvim.plugins.extras.ui.mini-indentscope" },
  {
    "nvim-mini/mini.indentscope",
    optional = true,
    opts = {
      mappings = {
        -- Textobjects
        object_scope = "hi", -- integrate with mini.ai
      },
    },
  },
}
