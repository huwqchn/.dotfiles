local M = {
  "jameshiew/nvim-magic",
  dependencies = {
    "plenary.nvim",
    { "MunifTanjim/nui.nvim" },
  },
  keys = {
    {
      "<leader>oo",
      "<cmd>lua require('nvim-magic.flows').append_completion(require('nvim-magic').backends.default)<cr>",
      desc = "append completion",
    },
    {
      "<leader>oa",
      "<cmd>lua require('nvim-magic.flows').suggest_alteration(require('nvim-magic').backends.default)<cr>",
      desc = "suggest alteration",
    },
    {
      "<leader>od",
      "<cmd>lua require('nvim-magic.flows').suggest_docstring(require('nvim-magic').backends.default)<cr>",
      desc = "generating a docstring",
    },
  },
}

M.init = function()
  saturn.plugins.whichkey.vmappings["o"] = {
    name = "+magic openai",
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
