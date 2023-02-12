return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
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
              find = "line",
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
              find = "search",
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

      pcall(function()
        require("telescope").load_extension("noice")
      end)
    end,

    deactivate = function()
      require("noice").disable()
    end,
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>ul", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>uh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>ua", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward" },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward"},
    },
  },
}
