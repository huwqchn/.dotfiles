local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

vim.keymap.set('n', "<space><space>", ":e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.c,<CR>", { noremap = true, silent = true } )

vim.bo.textwidth   = 100
vim.bo.tabstop     = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth  = 4

vim.bo.commentstring = '// %s'

vim.bo.cindent = true -- stricter rules for C programs
vim.opt.cinoptions:append('g0')
