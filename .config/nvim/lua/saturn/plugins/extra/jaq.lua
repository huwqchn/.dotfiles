local M = {}

function M.config()
  saturn.plugins.jaq = {
    active = true,
    on_config_done = nil,
    cmds = {
      -- Uses vim commands
      internal = {
        lua = "luafile %",
        vim = "source %",
      },

      -- Uses shell commands
      external = {
        markdown = "glow %",
        go = "go run %",
        sh = "sh %",
        typescript = "deno run %",
        javascript = "node %",
        python = "python %",
        lua = "lua %",
        -- rust = "rustc % && ./$fileBase && rm $fileBase",
        rust = "cargo run",
        cpp = "g++ % -o $fileBase && ./$fileBase",
      },
    },

    behavior = {
      -- Default type
      default = "terminal",

      -- Start in insert mode
      startinsert = false,

      -- Use `wincmd p` on startup
      wincmd = false,

      -- Auto-save files
      autosave = false,
    },

    ui = {
      float = {
        -- See ':h nvim_open_win'
        border = "none",

        -- See ':h winhl'
        winhl = "Normal",
        borderhl = "FloatBorder",

        -- See ':h winblend'
        winblend = 0,

        -- Num from `0-1` for measurements
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,
      },

      terminal = {
        -- Window position
        position = "bot",

        -- Window size
        size = 60,

        -- Disable line numbers
        line_no = false,
      },

      quickfix = {
        -- Window position
        position = "bot",

        -- Window size
        size = 10,
      },
    },
  }
  if saturn.plugins.jaq.active then
    saturn.plugins.whichkey.mappings["j"] = {":silent only | Jaq<cr>", "Jaq"}
  end
end

function M.setup()
  local present, jaq = pcall(require, "jaq-nvim")
  if not present then
    return
  end

  jaq.setup(saturn.plugins.jaq)

  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_set_keymap
  keymap("n", "<m-x>", ":silent only | Jaq<cr>", opts)
  if saturn.plugins.jaq.on_config_done then
    saturn.plugins.jaq.on_config_done(jaq)
  end
end

return M
