local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

vim.keymap.set('n', "<space><space>", ":e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>", { noremap = true, silent = true } )

vim.opt.showtabline  = 4
vim.bo.textwidth   = 100
vim.bo.tabstop     = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth  = 4

vim.bo.commentstring = '// %s'

vim.bo.cindent = true -- stricter rules for C programs
vim.opt.cinoptions:append('g0')

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
  c = {
    name = "C/C++",
    d = { "<cmd>TSCppDefineClassFunc<cr>", "Define class function" },
    i = { "<cmd>TSCppMakeConcreteClass<cr>", "Derive class" },
    ["3"] = { "<cmd>TSCppRuleOf3", "rule 3" },
    ["5"] = { "<cmd>TSCppRuleOf5", "rule 5" },
  },
}

which_key.register(mappings, opts)

