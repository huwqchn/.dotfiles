local M = {}

function M.config()
  saturn.plugins.dap = {
    active = true,
    on_config_done = nil,
    breakpoint = {
      text = saturn.icons.ui.Bug,
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    },
    breakpoint_rejected = {
      text = saturn.icons.ui.Bug,
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = saturn.icons.ui.BoldArrowRight,
      texthl = "DiagnosticSignWarn",
      linehl = "Visual",
      numhl = "DiagnosticSignWarn",
    },
    log = {
      level = "info",
    },
    ui = {
      auto_open = true,
      notify = {
        threshold = vim.log.levels.INFO,
      },
      config = {
        expand_lines = true,
        icons = { expanded = "", collapsed = "", circular = "" },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "k",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.33 },
              { id = "breakpoints", size = 0.17 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 0.33,
            position = "right",
          },
          {
            elements = {
              { id = "repl", size = 0.45 },
              { id = "console", size = 0.55 },
            },
            size = 0.27,
            position = "bottom",
          },
        },
        floating = {
          max_height = 0.9,
          max_width = 0.5, -- Floats will be treated as percentage of your screen.
          border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
      },
    },
    install = {
      "python", {}
    }
  }
end

function M.setup()
  local present, dap = pcall(require, "dap")
  if not present then
    return
  end

  if saturn.use_icons then
    vim.fn.sign_define("DapBreakpoint", saturn.plugins.dap.breakpoint)
    vim.fn.sign_define("DapBreakpointRejected", saturn.plugins.dap.breakpoint_rejected)
    vim.fn.sign_define("DapStopped", saturn.plugins.dap.stopped)
  end

  dap.set_log_level(saturn.plugins.dap.log.level)

  if saturn.plugins.dap.on_config_done then
    saturn.plugins.dap.on_config_done(dap)
  end
end

function M.setup_ui()
  local present, dap = pcall(require, "dap")
  if not present then
    return
  end
  local dapui = require "dapui"
  dapui.setup(saturn.plugins.dap.ui.config)

  if saturn.plugins.dap.ui.auto_open then
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    -- dap.listeners.before.event_terminated["dapui_config"] = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited["dapui_config"] = function()
    --   dapui.close()
    -- end
  end
  local Log = require "saturn.plugins.log"

  -- until rcarriga/nvim-dap-ui#164 is fixed
  local function notify_handler(msg, level, opts)
    if level >= saturn.plugins.dap.ui.notify.threshold then
      return vim.notify(msg, level, opts)
    end

    opts = vim.tbl_extend("keep", opts or {}, {
      title = "dap-ui",
      icon = "",
      on_open = function(win)
        vim.api.nvim_buf_set_option(vim.api.nvim_win_get_buf(win), "filetype", "markdown")
      end,
    })

    -- vim_log_level can be omitted
    if level == nil then
      level = Log.levels["INFO"]
    elseif type(level) == "string" then
      level = Log.levels[(level):upper()] or Log.levels["INFO"]
    else
      -- https://github.com/neovim/neovim/blob/685cf398130c61c158401b992a1893c2405cd7d2/runtime/lua/vim/lsp/log.lua#L5
      level = level + 1
    end

    msg = string.format("%s: %s", opts.title, msg)
    Log:add_entry(level, msg)
  end

  local dapui_ok, _ = xpcall(function()
    require("dapui.util").notify = notify_handler
  end, debug.traceback)
  if not dapui_ok then
    Log:debug "Unable to override dap-ui logging level"
  end
end

return M
