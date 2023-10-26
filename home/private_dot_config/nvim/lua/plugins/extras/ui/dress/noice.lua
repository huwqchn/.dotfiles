---whether nvim runs in a GUI
---@return boolean
local function isGui()
  return vim.g.neovide or vim.g.goneovim or vim.g.started_by_firenvim
end

return {
  {
    "folke/noice.nvim",
    cond = not isGui(),
    opts = function(_, opts)
      opts.lsp.progress = {
        enabled = false,
      }
      table.insert(opts.routes, 1, {
        filter = {
          event = "msg_show",
          find = "%d+L, %d+B",
        },
        view = "mini",
      })
      table.insert(opts.routes, 1, {
        filter = {
          find = "offset_encodings",
        },
        opts = { skip = true },
      })
      table.insert(opts.routes, 1, {
        filter = {
          find = "charactre_offset",
        },
        opts = { skip = true },
      })
      table.insert(opts.routes, 1, {
        filter = {
          find = "method textDocument",
        },
        opts = { skip = true },
      })
      table.insert(opts.routes, 1, {
        filter = {
          find = "cmp_tabnine/source.lua:280",
        },
        opts = { skip = true },
      })
      table.insert(opts.routes, 1, {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      })
      opts.presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        cmdline_output_to_split = false,
        lsp_doc_border = true,
      }
      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }
      opts.format = {
        level = {
          icons = false,
        },
      }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })
    end,
  },
}
