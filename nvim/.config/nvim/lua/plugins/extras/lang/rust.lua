return {
  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function(_, opts)
      for _, server in ipairs(opts.servers) do
        for _, key in ipairs(server.keys) do
          if key[1] == "K" then
            key[1] = "I"
          end
        end
      end
    end,
  },
}
