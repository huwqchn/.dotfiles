vim.keymap.set(
  "n",
  "<space><space>",
  ":e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>",
  { noremap = true, silent = true }
)

vim.opt_local.textwidth = 100
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

vim.opt_local.commentstring = "// %s"

vim.opt_local.cindent = true -- stricter rules for C programs
vim.opt_local.cinoptions:append("g0,N-s,E-s,l1,:0")
vim.wo.wrap = false

require("saturn.plugins.lsp.languages.cpp")

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "v", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  n = {
    name = "C/C++",
    d = { "<cmd>TSCppDefineClassFunc<cr>", "Define class function" },
    i = { "<cmd>TSCppMakeConcreteClass<cr>", "Derive class" },
    ["3"] = { "<cmd>TSCppRuleOf3", "rule 3" },
    ["5"] = { "<cmd>TSCppRuleOf5", "rule 5" },
  },
}

which_key.register(mappings, opts)
