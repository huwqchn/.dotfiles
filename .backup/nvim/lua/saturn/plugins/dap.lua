local M = {
  "mfussenegger/nvim-dap",
  keys = {
    { "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
    { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back" },
    { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
    { "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor" },
    { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect" },
    { "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session" },
    { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
    { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
    { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
    { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause" },
    { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl" },
    { "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start" },
    { "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit" },
    { "<leader>dU", "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI" },
  },
}

M.dependencies = {
  -- Debugger user interface
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      M.config_ui()
    end,
  },
  { "mxsdev/nvim-dap-vscode-js" },
  { "mfussenegger/nvim-dap-python", ft = "python" },
  { "leoluz/nvim-dap-go", ft = "go" },
}

saturn.plugins.dap = {
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
}

function M.init()
  saturn.plugins.whichkey.mappings.d = {
    name = "Debug",
  }
end

function M.config()
  local dap = require("dap")

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

function M.config_ui()
  local present, dap = pcall(require, "dap")
  if not present then
    return
  end
  local dapui = require("dapui")
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

    msg = string.format("%s: %s", opts.title, msg)
  end

  local dapui_ok, _ = xpcall(function()
    require("dapui.util").notify = notify_handler
  end, debug.traceback)
  if not dapui_ok then
    print("Unable to override dap-ui logging level")
  end
end

return M
