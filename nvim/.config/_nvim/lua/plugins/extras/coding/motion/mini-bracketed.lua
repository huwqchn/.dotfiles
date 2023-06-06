return {
	{
		"echasnovski/mini.bracketed",
		event = "BufReadPost",
		opts = {
			file = { suffix = "" },
			window = { suffix = "" },
			quickfix = { suffix = "" },
			yank = { suffix = "" },
			treesitter = { suffix = "n" },
		},
		-- config = function(_, opts)
		--   local bracketed = require("mini.bracketed")
		--   local function put(cmd, regtype)
		--     local body = vim.fn.getreg(vim.v.register)
		--     local type = vim.fn.getregtype(vim.v.register)
		--     ---@diagnostic disable-next-line: param-type-mismatch
		--     vim.fn.setreg(vim.v.register, body, regtype or "l")
		--     bracketed.register_put_region()
		--     vim.cmd(('normal! "%s%s'):format(vim.v.register, cmd:lower()))
		--     ---@diagnostic disable-next-line: param-type-mismatch
		--     vim.fn.setreg(vim.v.register, body, type)
		--   end
		--
		--   for _, cmd in ipairs({ "]p", "[p" }) do
		--     vim.keymap.set("n", cmd, function()
		--       put(cmd)
		--     end)
		--   end
		--   for _, cmd in ipairs({ "]P", "[P" }) do
		--     vim.keymap.set("n", cmd, function()
		--       put(cmd, "c")
		--     end)
		--   end
		--
		--   local put_keys = { "p", "P" }
		--   for _, lhs in ipairs(put_keys) do
		--     vim.keymap.set({ "n", "x" }, lhs, function()
		--       return bracketed.register_put_region(lhs)
		--     end, { expr = true })
		--   end
		--   bracketed.setup(opts)
		-- end,
	},
}
