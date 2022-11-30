local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

vim.keymap.set('n', "<space><space>", ":e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>", { noremap = true, silent = true } )
