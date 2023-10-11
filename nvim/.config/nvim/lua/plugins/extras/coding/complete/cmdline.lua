return {
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    event = "CmdlineEnter",
    opts = function(_, opts)
      opts.cmdline = {
        {
          type = ":",
          sources = {
            { name = "path" },
            { name = "cmdline" },
            { name = "cmdline_history" },
          },
        },
        {
          type = { "/", "?" },
          sources = {
            { name = "buffer" },
            { name = "cmdline_history" },
          },
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)
      for _, option in ipairs(opts.cmdline) do
        cmp.setup.cmdline(option.type, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = option.sources,
        })
      end
    end,
  },
}
