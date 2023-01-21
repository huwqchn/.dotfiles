require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        find = "%d+L, %d+B",
      },
      view = "mini",
    },
    {
      filter = {
        find = "lines",
      },
      view = "mini",
    },
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
    {
      filter = {
        find = "changed",
      },
      view = "mini",
    },
    {
      filter = {
        find = "offset_encodings",
      },
      opts = { skip = true },
    },
    {
      filter = {
        find = "charactre_offset",
      },
      opts = { skip = true },
    },
    {
      filter = {
        find = "method textDocument",
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = "notify",
        min_height = 15,
      },
      view = "split",
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
    cmdline_output_to_split = false,
  },
  commands = {
    all = {
      -- options for the message history that you get with `:Noice`
      view = "split",
      opts = { enter = true, format = "details" },
      filter = {},
    },
  },
  format = {
    level = {
      icons = false,
    },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(event)
    vim.schedule(function()
      require("noice.text.markdown").keys(event.buf)
    end)
  end,
})
