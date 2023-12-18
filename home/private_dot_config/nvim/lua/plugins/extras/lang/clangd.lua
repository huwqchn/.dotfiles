return {
  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function(_, opts)
      for _, key in ipairs(opts.servers.clangd.keys) do
        if key[1] == "<leader>cR" then
          key[1] = "s<space>"
          break
        end
      end
    end,
  },
}
