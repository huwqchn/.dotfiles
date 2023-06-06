--- Get current buffer size
---@return {width: number, height: number}
local function get_buf_size()
	local cbuf = vim.api.nvim_get_current_buf()
	local bufinfo = vim.tbl_filter(function(buf)
		return buf.bufnr == cbuf
	end, vim.fn.getwininfo(vim.api.nvim_get_current_win()))[1]
	if bufinfo == nil then
		return { width = -1, height = -1 }
	end
	return { width = bufinfo.width, height = bufinfo.height }
end

--- Get the dynamic terminal size in cells
---@param direction number
---@param size number
---@return integer
local get_dynamic_terminal_size = function(direction, size)
	if direction ~= "float" and tostring(size):find(".", 1, true) then
		size = math.min(size, 1.0)
		local buf_sizes = get_buf_size()
		local buf_size = direction == "horizontal" and buf_sizes.height or buf_sizes.width
		return buf_size * size
	else
		return size
	end
end

local _exec_toggle = function(opts)
	local Terminal = require("toggleterm.terminal").Terminal
	local term = Terminal:new({ cmd = opts.cmd, count = opts.count, direction = opts.direction })
	term:toggle(opts.size, opts.direction)
end

local add_exec = function(opts)
	local binary = opts.cmd:match("(%S+)")
	if vim.fn.executable(binary) ~= 1 then
		vim.notify("Skipping configuring executable " .. binary .. ". Please make sure it is installed properly.")
		return
	end

	vim.keymap.set({ "n", "t" }, opts.keymap, function()
		_exec_toggle({ cmd = opts.cmd, count = opts.count, direction = opts.direction, size = opts.size() })
	end, { desc = opts.label, noremap = true, silent = true })
end

local lazygit_toggle = function()
	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({
		cmd = "lazygit",
		hidden = true,
		direction = "float",
		float_opts = {
			border = "none",
			width = 100000,
			height = 100000,
		},
		on_open = function(_)
			vim.cmd("startinsert!")
		end,
		on_close = function(_) end,
		count = 99,
	})
	lazygit:toggle()
end

local btop_toggle = function()
	local Terminal = require("toggleterm.terminal").Terminal
	local btop = Terminal:new({
		cmd = "btop",
		hidden = true,
		direction = "float",
		float_opts = {
			border = "none",
			width = 100000,
			height = 100000,
		},
		on_open = function(_)
			vim.cmd("startinsert!")
		end,
		on_close = function(_) end,
		count = 98,
	})
	btop:toggle()
end

return {
	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
		opts = {
			shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
			direction = "float", -- change the default shell
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlight = {
					border = "Normal",
					backgrounds = "Normal",
				},
			},
			execs = {
				{ nil, "<M-S-1>", "Horizontal Terminal", "horizontal", 0.3 },
				{ nil, "<M-S-2>", "Vertical Terminal", "vertical", 0.4 },
				{ nil, "<M-S-3>", "Float Terminal", "float", nil },
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
			for i, exec in pairs(opts.execs) do
				local direction = exec[4] or opts.direction

				local exec_opts = {
					cmd = exec[1] or opts.shell,
					keymap = exec[2],
					label = exec[3],
					-- NOTE: unable to consistently bind id/count <= 9, see #2146
					count = i + 100,
					direction = direction,
					size = function()
						return get_dynamic_terminal_size(direction, exec[5])
					end,
				}

				add_exec(exec_opts)
			end
		end,
		keys = {
			{ "<leader><cr>p", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "python" },
			{ "<leader><cr><cr>", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
			{ "<leader><cr>/", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal" },
			{ "<leader><cr>\\", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical" },
			{ "<leader><cr><tab>", "<cmd>ToggleTerm direction=tab<cr>", desc = "Tab" },
			{
				"<leader>gg",
				lazygit_toggle,
				desc = "LazyGit",
			},
			{
				"<leader>xb",
				btop_toggle,
				desc = "btop",
			},
			{ "<M-S-1>" },
			{ "<M-S-2>" },
			{ "<M-S-3>" },
		},
	},
}
