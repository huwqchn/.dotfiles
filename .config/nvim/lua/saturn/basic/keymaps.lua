local M = {}
local opts_any = { noremap = true, silent = true }
-- local opts_remap = { remap = true, silent = true }

-- Mods
--	 normal_mode = "n",
--	 insert_mode = "i",
--	 visual_mode = "v",
--	 visual_block_mode = "x",
--	 term_mode = "t",
--	 command_mode = "c",

M.general_opts = {
	[""] = opts_any,
	["i"] = opts_any,
	["n"] = opts_any,
	["v"] = opts_any,
	["x"] = opts_any,
	["c"] = opts_any,
	["t"] = { silent = true },
}

M.general = {
	[""] = {
		-- colemak movement
		["u"] = "k",
		["n"] = "h",
		["e"] = "j",
		["i"] = "l",

		-- colemak insert key
		["k"] = "i",
		["K"] = "I",

		-- colemak undo key
		["l"] = "u",
		["L"] = "U",

		-- colemak better searching key
		["-"] = "N",
		["="] = "n",

		-- colemak goto key
		-- ["t"] = { "g", opts_remap },
		-- ["T"] = "G",

    --   ["j"] = "t",
    --   ["J"] = "T",

		["gt"] = "gg",
		["gu"] = "gk",
		["ge"] = "gj",

		-- colemak faster navigation
		["U"] = "5k",
		["E"] = "5j",

		-- colemak jump to start/end of the line
		["N"] = "^",
		["I"] = "$",

		-- colemak end of word
		["h"] = "e",
		["H"] = "E",

		-- faster in-line navigation
		-- ["W"] = "5w",
		-- ["B"] = "5b",

		-- convenient keymaps
		-- [";"] = ":",
		-- ["`"] = "~",
    ["S"] = ":w<CR>",
    ["Q"] = ":q<CR>",

    -- nohl
    ["<C-l>"] = ":nohl<CR>",
	},
  ["i"] = {
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-e>"] = "<Esc>:m .+1<CR>==gi",
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-u>"] = "<Esc>:m .-2<CR>==gi",
    -- navigation
    ["<A-Up>"] = "<C-\\><C-N><C-w>k",
    ["<A-Down>"] = "<C-\\><C-N><C-w>j",
    ["<A-Left>"] = "<C-\\><C-N><C-w>h",
    ["<A-Right>"] = "<C-\\><C-N><C-w>l",
  },
	["n"] = {
		-- better indentation
		["<"] = "<<",
		[">"] = ">>",

		-- make Y to copy till the end of the line
		["Y"] = "y$",

		-- Better window movement
		["<C-w>"] = "<C-w>w",
		["<C-n>"] = "<C-w>h",
		["<C-e>"] = "<C-w>j",
		["<C-u>"] = "<C-w>k",
		["<C-i>"] = "<C-w>l",
		["<C-y>"] = "<C-w>o",
    ["<C-b>"] = "<C-w>=",
    ["<C-h>"] = "<C-o>",
    ["<C-o>"] = "<C-i>",
		["<C-q>"] = "<C-w>q",
		-- Disable the default s key
		["s"] =  "<nop>",
		-- split the screens to horizontal (up / down) and vertical (left / right)
		["su"] = ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>",
		["se"] = ":set splitbelow<CR>:split<CR>",
		["sn"] = ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>",
		["si"] = ":set splitright<CR>:vsplit<CR>",

		-- -- place the two screens up and down
		["sh"] = "<C-w>t<C-w>K",
		-- -- place the two screens side by side
		["sv"] = "<C-w>t<C-w>H",

		-- Rotate screens
		["sr"] = "<C-w>b<C-w>K",
		["sR"] = "<C-w>b<C-w>H",

		-- Resize with arrows
		["<C-Up>"] = ":resize -2<CR>",
		["<C-Down>"] = ":resize +2<CR>",
		["<C-Left>"] = ":vertical resize -2<CR>",
		["<C-Right>"] = ":vertical resize +2<CR>",

		-- Move current line / block up / down
    ["<A-e>"] = ":m .+1<CR>==",
		["<A-u>"] = ":m .-2<CR>==",

		-- QuickFix
		["]]"] = ":cnext<CR>",
		["[["] = ":cprev<CR>",
		-- ["<C-q>"] = ":call QuickFixToggle()<CR>",

		-- Delete pair
		["dy"] = "d%",

    -- inc/dec numbers
    ["<leader>="] = "<C-a>",
    ["<leader>-"] = "<C-x>",
	},
	["v"] = {
		-- copy to system clipboard
		["Y"] = '"+y',

    -- Better indenting
    ["<"] = "<gv",
    [">"] = ">gv",


    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-e>"] = ":m '>+1<CR>gv-gv",
    ["<A-u>"] = ":m '<-2<CR>gv-gv",
	},
	["x"] = {
    -- Move current line / block with Alt-e/u ala vscode.
    ["<A-e>"] = ":m '>+1<CR>gv-gv",
    ["<A-u>"] = ":m '<-2<CR>gv-gv",

    -- replace in selection
    ["s"] = ":s/\\%V",
	},
	["t"] = {
    -- Terminal window navigation
    ["<C-n>"] = "<C-\\><C-N><C-w>h",
    ["<C-e>"] = "<C-\\><C-N><C-w>j",
    ["<C-u>"] = "<C-\\><C-N><C-w>k",
    ["<C-i>"] = "<C-\\><C-N><C-w>l",
	},
	["c"] = {
    -- navigate tab completion with <c-j> and <c-k>
    -- runs conditionally
    ["<C-e>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
    ["<C-u>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
	}
}

function M.set_keymaps(mode, key, val)
	local opt = M.general_opts[mode] or opts_any
	if type(val) == "table" then
		opt = val[2]
		val = val[1]
	end
	if val then
		vim.keymap.set(mode, key, val, opt)
	else
		pcall(vim.api.nvim_del_keymap, mode, key)
	end
end

function M.load()
  vim.keymap.set("", saturn.leaderkey, "<Nop>", opts_any)
  vim.g.mapleader = saturn.leaderkey
  vim.g.maplocalleader = saturn.leaderkey
	for mode, maps in pairs(M.general) do
		for key, val in pairs(maps) do
			M.set_keymaps(mode, key, val)
		end
	end
  saturn.keys = M.general
end

return M
