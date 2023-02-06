vim.opt_local.textwidth = 100
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.commentstring = "//  %s"
vim.opt_local.cindent = true
vim.opt_local.cinoptions:append("g0,N-s,E-s,l1,:0")
vim.wo.wrap = false

require("saturn.plugins.lsp.null-ls.formatters").setup({
  { command = "clang-format", filetype = { "cpp" } },
})

require("saturn.plugins.lsp.manager").setup("clangd", {
  on_attach = function(client, bufnr)
    vim.keymap.set(
      "n",
      "<leader><space>",
      "<cmd>ClangdSwitchSourceHeader<cr>",
      { desc = "switch between header and source" }
    )
    require("saturn.plugins.lsp.hooks").common_on_attach(client, bufnr)
  end,
})
saturn.plugins.dap.on_config_done = function(dap)
  local get_args = function()
    local cmd_args = vim.fn.input("CommandLine Args:")
    local params = {}
    local sep = "%s"
    for param in string.gmatch(cmd_args, "[^%s]+") do
      table.insert(params, param)
    end
    return params
  end

  local function get_executable_from_cmake(path)
    local get_executable = 'awk "BEGIN {IGNORECASE=1} /add_executable\\s*\\([^)]+\\)/ {match(\\$0, /\\(([^\\)]+)\\)/,m);match(m[1], /([A-Za-z_]+)/, n);printf(\\"%s\\", n[1]);}" '
      .. path
      .. "CMakeLists.txt"
    return vim.fn.system(get_executable)
  end

  dap.adapters.lldb = {
    type = "executable",
    -- absolute path is important here, otherwise the argument in the `runInTerminal` request will default to $CWD/lldb-vscode
    command = "/usr/bin/lldb-vscode",
    name = "lldb",
  }
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        local current_path = vim.fn.getcwd() .. "/"
        -- use find cmd find Makefile or makefile
        local fd_make = string.format("find %s -maxdepth 1 -name [m\\|M]akefile", current_path)
        local fd_make_result = vim.fn.system(fd_make)
        if fd_make_result ~= "" then
          local mkf = vim.fn.system(fd_make)
          -- use awk extract Makefile(makefile) the first exec file name
          local cmd = 'awk "\\$0 ~ /:/ { match(\\$1, \\"([A-Za-z_]+)\\", m); printf(\\"%s\\", m[1]); exit; }" ' .. mkf
          local exe = vim.fn.system(cmd)
          -- exec make
          -- Makefile need set CXXFLAGS
          if os.execute('make CXXFLAGS="-g"') then
            return current_path .. exe
          end
        end
        -- find CMakeLists.txt
        local fd_cmake = string.format("find %s -name CMakeLists.txt -type f", current_path)
        local fd_cmake_result = vim.fn.system(fd_cmake)
        if fd_cmake_result == "" then
          return vim.fn.input("Path to executable: ", current_path, "file")
        end
        -- search build folder
        local fd_build = string.format("find %s -name build -type d", current_path)
        local fd_build_result = vim.fn.system(fd_build)
        if fd_build_result == "" then
          -- create build folder if not exist
          if not os.execute(string.format("mkdir -p %sbuild", current_path)) then
            return vim.fn.input("Path to executable: ", current_path, "file")
          end
        end
        local cmd = "cd " .. current_path .. "build && cmake .. -DCMAKE_BUILD_TYPE=Debug"
        -- start building
        print("Building The Project...")
        vim.fn.system(cmd)
        local exec = get_executable_from_cmake(current_path)
        local make = "cd " .. current_path .. "build && make"
        local res = vim.fn.system(make)
        if exec == "" or res == "" then
          return vim.fn.input("Path to executable: ", current_path, "file")
        end
        return current_path .. "build/" .. exec
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = get_args,
      runInTerminal = true,
    },
  }
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

  dap.listeners.after["event_terminated"]["me"] = function()
    for _, keymap in pairs(keymap_restore) do
      api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, { silent = keymap.silent == 1 })
    end
    keymap_restore = {}
  end
end
