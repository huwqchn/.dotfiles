local M = {}

local dap_keymap = function(dap)
  local api = vim.api
  local keymap_restore = {}
  dap.listeners.after["event_initialized"]["me"] = function()
    for _, buf in pairs(api.nvim_list_bufs()) do
      local keymaps = api.nvim_buf_get_keymap(buf, "n")
      for _, keymap in pairs(keymaps) do
        if keymap.lhs == "H" then
          table.insert(keymap_restore, keymap)
          api.nvim_buf_del_keymap(buf, "n", "H")
        end
      end
    end
    api.nvim_set_keymap("n", "H", '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
  end

  --FIXME: can't restore my key
  dap.listeners.after["event_terminated"]["me"] = function()
    for _, keymap in pairs(keymap_restore) do
      api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, { silent = keymap.silent == 1 })
    end
    keymap_restore = {}
  end
end

local args = function()
  local cmd_args = vim.fn.input("CommandLine Args:")
  local params = {}
  for param in string.gmatch(cmd_args, "[^%s]+") do
    table.insert(params, param)
  end
  return params
end

M.cppdbg_config = function(dap)
  local mason_path = vim.fn.glob(vim.fn.stdpath("data")) .. "/mason/"
  local cppdbg_exec_path = mason_path .. "packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"
  dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = cppdbg_exec_path,
  }

  dap.configurations.cpp = {
    { --launch
      name = "Launch",
      type = "cppdbg",
      request = "launch",
      program = function()
        ---@diagnostic disable-next-line: redundant-parameter
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = args,
      setupCommands = {
        {
          description = "enable pretty printing",
          text = "-enable-pretty-printing",
          ignoreFailures = false,
        },
      },
    },
    { -- attach
      name = "Attach process",
      type = "cppdbg",
      request = "attach",
      processId = require("dap.utils").pick_process,
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      setupCommands = {
        {
          description = "enable pretty printing",
          text = "-enable-pretty-printing",
          ignoreFailures = false,
        },
      },
    },
  }
  dap.configurations.c = dap.configurations.cpp
end

M.codelldb_config = function(dap)
  local mason_path = vim.fn.glob(vim.fn.stdpath("data")) .. "/mason/"
  local codelldb_exec_path = mason_path .. "packages/codelldb/codelldb"

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = codelldb_exec_path,
      args = { "--port", "${port}" },
    },
  }

  dap.configurations.cpp = {
    { -- launch
      name = "Launch",
      type = "codelldb",
      request = "launch",
      program = function()
        ---@diagnostic disable-next-line: redundant-parameter
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = args,
    },
    { -- attach
      name = "Attach process",
      type = "codelldb",
      request = "attach",
      processId = require("dap.utils").pick_process,
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
    },
  }
  dap.configurations.c = dap.configurations.cpp
  -- dap_keymap(dap)
end

return M
