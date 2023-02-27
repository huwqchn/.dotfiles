---whether nvim runs in a GUI
---@return boolean
local function isGui()
  return vim.g.neovide or vim.g.goneovim or vim.g.started_by_firenvim
end

return {
  {
    "karb94/neoscroll.nvim",
    enabled = false,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      local Util = require("saturn.utils.plugin")
      if not Util.has("noice.nvim") then
        Util.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end
    end,
    cond = not isGui(),
    config = function()
      require("noice").setup({
        lsp = {
          progress = {
            enabled = false,
          },
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
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = { skip = true },
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
          bottom_search = false,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = true,
          cmdline_output_to_split = false,
          lsp_doc_border = true,
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
