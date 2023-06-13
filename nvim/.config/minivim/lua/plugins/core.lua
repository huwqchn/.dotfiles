local function load(name)
	local Util = require("lazy.core.util")
	local function _load(mod)
		Util.try(function()
			require(mod)
		end, {
			msg = "Failed loading " .. mod,
			on_error = function(msg)
				local info = require("lazy.core.cache").find(mod)
				if info == nil or (type(info) == "table" and #info == 0) then
					return
				end
				Util.error(msg)
			end,
		})
	end
	_load("config." .. name)
	if vim.bo.filetype == "lazy" then
		-- HACK: Saturn may have overwritten options of the Lazy ui, so reset this here
		vim.cmd([[do VimResized]])
	end
end
-- load options here, before lazy init while sourcing plugin modules
-- this is needed to make sure options will be correctly applied
-- after installing missing plugins
load("options")

if vim.fn.argc(-1) == 0 then
	-- autocmds and keymaps can wait to load
	vim.api.nvim_create_autocmd("User", {
		group = vim.api.nvim_create_augroup("lite", { clear = true }),
		pattern = "VeryLazy",
		callback = function()
			load("autocmds")
			load("keymaps")
		end,
	})
else
	-- load them now so they affect the opened buffers
	load("autocmds")
	load("keymaps")
end

return {
	-- set to HEAD for now. I'm sill making too many changes for this repo related to lazy itself
	{
		"folke/lazy.nvim",
		version = "*",
	},
}
