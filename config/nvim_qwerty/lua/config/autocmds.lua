local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("_hide_dap_repl"),
  pattern = "dap-repl",
  command = "set nobuflisted",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("_filetype_settings"),
  pattern = { "lua" },
  desc = "fix gf functionality inside .lua files",
  callback = function()
    ---@diagnostic disable: assign-type-mismatch
    -- credit: https://github.com/sam4llis/nvim-lua-gf
    vim.opt_local.include = [[\v<((do|load)file|require|reload)[^''"]*[''"]\zs[^''"]+]]
    vim.opt_local.includeexpr = "substitute(v:fname,'\\.','/','g')"
    vim.opt_local.suffixesadd:prepend(".lua")
    vim.opt_local.suffixesadd:prepend("init.lua")

    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
      vim.opt_local.path:append(path .. "/lua")
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("_filetype_settings"),
  pattern = "qf",
  command = "set nobuflisted",
})

vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  desc = "don't auto comment new line",
  group = augroup("_comment"),
  pattern = "*",
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  group = augroup("fix_cr"),
  pattern = "quickfix",
  callback = function()
    vim.cmd([[
        nnoremap <silent> <buffer> <cr> <cr>
      ]])
  end,
})

vim.api.nvim_create_autocmd({ "CmdwinEnter" }, {
  group = augroup("fix_cr"),
  pattern = "*",
  callback = function()
    vim.cmd([[
        nnoremap <silent> <buffer> <cr> <cr>
      ]])
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "create directories when needed, when saving a file",
  group = augroup("better_backup"),
  callback = function(event)
    local file = vim.uv.fs_realpath(event.match) or event.match
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})
