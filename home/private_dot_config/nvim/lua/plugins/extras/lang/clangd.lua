return {
  { import = "lazyvim.plugins.extras.lang.clangd" },
  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function(_, opts)
      local keys = opts.servers.clangd.keys
      keys[#keys + 1] = { "s<space>", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" }
    end,
  },
}
