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
	-- {
	-- 	"xeluxee/competitest.nvim",
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- 	keys = {
	-- 		{ "<leader><space>", "<cmd>CompetiTestRun<cr>", desc = "Run with Test case" },
	-- 	},
	-- 	opts = {
	-- 		picker_ui = {
	-- 			mappings = {
	-- 				focus_next = { "e", "<down>", "<Tab>" },
	-- 				focus_prev = { "i", "<up>", "<S-Tab>" },
	-- 				close = { "<esc>", "<C-c>", "q", "Q" },
	-- 				submit = { "<cr>" },
	-- 			},
	-- 		},
	-- 		editor_ui = {
	-- 			normal_mode_mappings = {
	-- 				switch_window = { "<C-n>", "<C-o>", "<C-i>" },
	-- 				save_and_close = "<C-s>",
	-- 				cancel = { "q", "Q" },
	-- 			},
	-- 			insert_mode_mappings = {
	-- 				switch_window = { "<C-n>", "<C-o>", "<C-i>" },
	-- 				save_and_close = "<C-s>",
	-- 				cancel = "<C-q>",
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		"folke/which-key.nvim",
		keys = {
			{ "<leader>", mode = { "n", "v" } },
			{ "g", mode = { "n", "v" } },
			{ "s", mode = { "n", "v" } },
			{ "[", mode = { "n", "v" } },
			{ "]", mode = { "n", "v" } },
		},
		opts = {
			defaults = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["s"] = { name = "+surround/split/select" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>c"] = { name = "+code" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			},
			plugins = {
				marks = false,
				registers = false,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
				presets = {
					operators = false,
					motions = false,
					text_objects = false,
					windows = false,
					nav = false,
					z = false,
					g = false,
				},
			},
			operators = { gc = "Comments" },
			key_labels = { ["<leader>"] = "SPC" },
			window = {
				border = "single", -- none, single, double, shadow
				position = "bottom", -- bottom, top
				margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
				padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
				winblend = 0,
			},
		},
	},
}
