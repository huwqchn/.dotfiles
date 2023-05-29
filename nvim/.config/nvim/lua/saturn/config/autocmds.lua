local autocmd = require("saturn.utils.autocmd")

--- Load the default set of autogroups and autocommands.
local definitions = {
  {
    "TextYankPost",
    {
      group = "_general_settings",
      pattern = "*",
      desc = "Highlight text on yank",
      callback = function()
        vim.highlight.on_yank({ higroup = "Search", timeout = 100 })
      end,
    },
  },
  {
    "FileType",
    {
      group = "_hide_dap_repl",
      pattern = "dap-repl",
      command = "set nobuflisted",
    },
  },
  {
    { "FocusGained", "TermClose", "TermLeave" },
    {
      group = "checktime",
      command = "checktime",
    },
  },
  {
    "FileType",
    {
      group = "_filetype_settings",
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
    },
  },
  {
    "FileType",
    {
      group = "_buffer_mappings",
      pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "floaterm",
        "lspinfo",
        "lir",
        "lsp-installer",
        "null-ls-info",
        "tsplayground",
        "DressingSelect",
        "Jaq",
        "spectre_pannel",
        "startuptime",
        "tspluayground",
        "PlenaryTestPopup",
      },
      callback = function()
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
        vim.opt_local.buflisted = false
      end,
    },
  },
  {
    "FileType",
    {
      group = "wrap_spell",
      pattern = { "gitcommit", "markdown" },
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
      end,
    },
  },
  {
    "FileType",
    {
      group = "_filetype_settings",
      pattern = "qf",
      command = "set nobuflisted",
    },
  },
  {
    "VimResized",
    {
      group = "_auto_resize",
      pattern = "*",
      command = "tabdo wincmd =",
    },
  },
  {
    "FileType",
    {
      group = "_filetype_settings",
      pattern = "alpha",
      callback = function()
        vim.cmd([[
            nnoremap <silent> <buffer> q :qa<CR>
            nnoremap <silent> <buffer> <esc> :qa<CR>
            set nobuflisted
          ]])
      end,
    },
  },
  {
    "FileType",
    {
      group = "_filetype_settings",
      pattern = "lir",
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
      end,
    },
  },
  {
    "ColorScheme",
    {
      group = "_saturn_colorscheme",
      callback = function()
        require("saturn.plugins.ui.breadcrumbs").get_winbar()
        local statusline_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
        local cursorline_hl = vim.api.nvim_get_hl_by_name("CursorLine", true)
        local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
        vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
        vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
        vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
        vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
        vim.api.nvim_set_hl(0, "CmpItemKindCodeium", { fg = "#7AA2F7" })
        vim.api.nvim_set_hl(0, "SLCopilot", { fg = "#6CC644", bg = statusline_hl.background })
        vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = cursorline_hl.background })
        vim.api.nvim_set_hl(0, "SLBranchName", { fg = normal_hl.foreground, bg = cursorline_hl.background })
        vim.api.nvim_set_hl(0, "SLSeparator", { fg = cursorline_hl.background, bg = statusline_hl.background })
      end,
    },
  },
  -- Enable spell checking for certain file types
  {
    { "BufRead", "BufNewFile" },
    {
      group = "_spell_check",
      pattern = { "*.txt", "*.md", "*.tex" },
      command = "setlocal spell",
    },
  },
  {
    { "BufWritePre" },
    {
      group = "_remove_trailing_whitespace",
      pattern = { "*" },
      callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
      end,
    },
  },
  -- go to last loc when opening a buffer
  -- {
  --   "BufReadPost",
  --   {
  --     group = "last_loc",
  --     callback = function()
  --       local mark = vim.api.nvim_buf_get_mark(0, '"')
  --       local lcount = vim.api.nvim_buf_line_count(0)
  --       if mark[1] > 0 and mark[1] <= lcount then
  --         pcall(vim.api.nvim_win_set_cursor, 0, mark)
  --       end
  --     end,
  --   },
  -- },
  {
    "BufWinLeave",
    {
      group = "rememberCursorAndFolds",
      pattern = "?*",
      callback = function()
        autocmd.remember("save")
      end,
    },
  },
  {
    "BufWinEnter",
    {
      group = "rememberCursorAndFolds",
      pattern = "?*",
      callback = function()
        autocmd.remember("load")
      end,
    },
  },
}

autocmd.create_autocmds(definitions)
