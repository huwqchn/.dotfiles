return {
	-- search/replace in multiple files
	{
		"nvim-pack/nvim-spectre",
		cmd = "Spectre",
		opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
	},

	-- structural replace
	{
		"cshuaimin/ssr.nvim",
		keys = {
			{
				"<leader>sR",
				function()
					require("ssr").open()
				end,
				mode = { "n", "x" },
				desc = "Structural Replace",
			},
		},
	},
	-- easily jump to any location and enhanced f/t motions for Leap
	{
		"ggandor/flit.nvim",
		keys = function()
			---@type LazyKeys[]
			local ret = {}
			for _, key in ipairs({ "f", "F", "t", "T" }) do
				ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
			end
			return ret
		end,
		opts = { labeled_modes = "nxo" },
	},
	{
		"ggandor/leap.nvim",
		keys = function()
			return {
				{
					"<leader>j",
					"<cmd>lua require('leap').leap { target_windows = { vim.fn.win_getid() } }<cr>",
					desc = "jump",
					mode = { "n", "x" },
				},
				{
					"<leader>J",
					"<cmd>lua require('leap').leap { target_windows = vim.tbl_filter(function (win) return vim.api.nvim_win_get_config(win).focusable end,vim.api.nvim_tabpage_list_wins(0))}<cr>",
					desc = "jump to any window",
					mode = { "n", "x" },
				},
				{ ";", "<Plug>(leap-forward-to)", desc = "leap forward to", mode = { "n", "x", "o" } },
				{ ":", "<Plug>(leap-backward-to)", desc = "leap backward to", mode = { "n", "x", "o" } },
				{ "g:", "<Plug>(leap-cross-window)", desc = "leap cross window", mode = { "n", "x", "o" } },
				{ "x", "<Plug>(leap-forward-till)", desc = "leap forward till", mode = { "x", "o" } },
				{ "X", "<Plug>(leap-backward-till)", desc = "leap backward till", mode = { "x", "o" } },
			}
		end,
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
		end,
	},
}
