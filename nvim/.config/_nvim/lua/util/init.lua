local M = {}
M.autocmd = require("util.autocmd")

--- lazy load lsp module by filetype
---@param filetype string
---@param setup fun()
function M.on_lsp_lazy(filetype, setup)
	M.autocmd.create_autocmds("FileType", {
		group = "_ON_LAZY_SETUP_LSP",
		pattern = filetype,
		callback = setup,
	})
end

--- do not create the keymap if a lazy keys handler exists
---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts table|nil
function M.lazy_keymap(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= false
		if opts.remap and not vim.g.vscode then
			opts.remap = nil
		end
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

return M
