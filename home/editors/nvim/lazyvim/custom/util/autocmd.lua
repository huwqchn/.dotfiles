local M = {}

-- Create user defined command based on the passed collection
---@param cmd table contains a tuple of name, fn, opts
function M.create_user_command(cmd)
	local common_opts = { force = true }
	local opts = vim.tbl_deep_extend("force", common_opts, cmd.opts or {})
	vim.api.nvim_create_user_command(cmd.name, cmd.fn, opts)
end

--- Create autocommand groups based on opts
--- Also creates the augroup automatically if it doesn't exist
---@param event string
---@param opts table
function M.create_autocmds(event, opts)
	if type(opts.group) == "string" and opts.group ~= "" then
		local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
		if not exists then
			vim.api.nvim_create_augroup(opts.group, {})
		end
	end
	vim.api.nvim_create_autocmd(event, opts)
end

--- Clean autocommand in a group if it exists
--- This is safer than trying to delete the augroup itself
---@param name string the augroup name
function M.clear_augroup(name)
	-- defer the function in case the autocommand is still in-use
	vim.schedule(function()
		pcall(function()
			vim.api.nvim_clear_autocmds({ group = name })
		end)
	end)
end

---runs :normal natively with bang
---@param cmdStr any
local function normal(cmdStr)
	vim.cmd.normal({ cmdStr, bang = true })
end

-- Remember folds and cursor
function M.remember(mode)
	local ignoredFts = {
		"DressingInput",
		"DressingSelect",
		"TelescopePrompt",
		"gitcommit",
		"toggleterm",
		"help",
		"qf",
	}
	if vim.tbl_contains(ignoredFts, vim.bo.filetype) or vim.bo.buftype == "nofile" or not vim.bo.modifiable then
		return
	end
	if mode == "save" then
		vim.cmd.mkview(1)
	else
		vim.cmd([[silent! loadview 1]]) -- needs silent to avoid error for documents that do not have a view yet (opening first time)
		normal("0^") -- to scroll to the left on start
	end
end

return M
