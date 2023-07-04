return {
  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function(_, opts)
      for _, key in ipairs(opts.servers.rust_analyzer.keys) do
        if key[1] == "K" then
          key[1] = "I"
          break
        end
      end
      for _, key in ipairs(opts.servers.taplo.keys) do
        if key[1] == "K" then
          key[1] = "I"
          break
        end
      end
    end,
  },
}
