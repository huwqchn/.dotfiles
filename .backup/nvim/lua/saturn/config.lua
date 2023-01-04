saturn.plugins.luasnip = {
  sources = {
    friendly_snippets = false,
  },
}

saturn.plugins.bigfile = {
  active = false,
  config = {},
}

require("saturn.plugins.lsp").config()
require("saturn.plugins.whichkey").preinit()
require("saturn.plugins.theme").preinit()
require("saturn.plugins.gitsigns").preinit()
require("saturn.plugins.cmp").preinit()
require("saturn.plugins.dap").preinit()
require("saturn.plugins.toggleterm").preinit()
require("saturn.plugins.telescope").preinit()
require("saturn.plugins.treesitter").preinit()
require("saturn.plugins.nvim-tree").preinit()
require("saturn.plugins.lir").preinit()
require("saturn.plugins.illuminate").preinit()
require("saturn.plugins.indentline").preinit()
require("saturn.plugins.breadcrumbs").preinit()
require("saturn.plugins.project").preinit()
require("saturn.plugins.bufferline").preinit()
require("saturn.plugins.autopairs").preinit()
require("saturn.plugins.comment").preinit()
require("saturn.plugins.lualine").preinit()
require("saturn.plugins.mason").preinit()
-- debug
-- saturn.plugins.lualine.active = false
-- saturn.plugins.telescope.active = false
-- saturn.plugins.autopairs.active = false
-- saturn.plugins.breadcrumbs.active = false
-- saturn.plugins.bufferline.active = false
-- saturn.plugins.cmp.active = false
-- saturn.plugins.comment.active = false
-- saturn.plugins.dap.active = false
-- saturn.plugins.gitsigns.active = false
-- saturn.plugins.illuminate.active = false
-- saturn.plugins.indentlines.active = false
-- saturn.plugins.lir.active = false
-- saturn.plugins.nvimtree.active = false
-- saturn.plugins.project.active = false
-- saturn.plugins.toggleterm.active = false
-- saturn.plugins.whichkey.active = false

-- custom
saturn.format_on_save.enabled = true
saturn.enable_extra_plugins = true
