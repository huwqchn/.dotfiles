local M = {
  "jameshiew/nvim-magic",
  dependencies = {
    "plenary.nvim",
    { "MunifTanjim/nui.nvim" },
  },
}

M.init = function()
  saturn.plugins.whichkey.vmappings["o"] = {
    name = "+magic openai",
    o = {
      "<cmd>lua require('nvim-magic.flows').append_completion(require('nvim-magic').backends.default)<cr>",
      "append completion",
    },
    a = {
      "<cmd>lua require('nvim-magic.flows').suggest_alteration(require('nvim-magic').backends.default)<cr>",
      "suggest alteration",
    },
    d = {
      "<cmd>lua require('nvim-magic.flows').suggest_docstring(require('nvim-magic').backends.default)<cr>",
      "generating a docstring",
    },
  }
end

M.config = function()
  require("nvim-magic").setup({
    backends = {
      default = require("nvim-magic-openai").new(),
    },
    use_default_keymap = false,
  })
end

return M
