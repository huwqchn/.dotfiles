return {
  settings = {
    Lua = {
      format = {
        enable = false, -- let null-ls handle the formatting
      },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        --path = runtime_path,
      },
      completion = { enable = true, callSnippet = "Both" },
      diagnostics = {
        enable = true,
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "describe" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
}
