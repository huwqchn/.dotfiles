local opts_any = { noremap = true, silent = true }
-- local opts_remap = { remap = true, silent = true }

-- Mods
--	 normal_mode = "n",
--	 insert_mode = "i",
--	 visual_mode = "v",
--	 visual_block_mode = "x",
--	 term_mode = "t",
--	 command_mode = "c",

local general_opts = {
  [""] = opts_any,
  ["i"] = opts_any,
  ["n"] = opts_any,
  ["v"] = opts_any,
  ["x"] = opts_any,
  ["c"] = opts_any,
  ["t"] = { silent = true },
}

local keys = {
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

    ["gu"] = "gk",
    ["ge"] = "gj",

    -- colemak faster navigation
    ["U"] = "<C-b>",
    ["E"] = "<C-f>",

    -- colemak jump to start/end of the line
    ["N"] = "^",
    ["I"] = "$",

    -- colemak end of word
    ["h"] = "e",
    ["H"] = "E",

    -- map return key to command_mode
    ["<CR>"] = ":",

    -- select all
    ["<C-a>"] = "ggVG",
    -- save
    ["<C-s>"] = ":wa<CR>",
    -- quit
    ["<C-q>"] = ":wq<CR>",
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

    -- undo
    ["<C-z>"] = "<C-o>u",

    -- paste
    ["<C-v>"] = "<C-g>u<Cmd>set paste<CR><C-r>+<Cmd>set nopaste<CR>",

    -- save
    ["<C-s>"] = "<C-g>u<Cmd>w<CR>",
  },
  ["n"] = {
    -- better indentation
    ["<"] = "<<",
    [">"] = ">>",

    -- Better window movement
    ["<C-w>"] = "<C-w>w",
    ["<C-n>"] = "<C-w>h",
    ["<C-e>"] = "<C-w>j",
    ["<C-u>"] = "<C-w>k",
    ["<C-i>"] = "<C-w>l",
    ["<C-l>"] = "<C-w>o",

    -- Disable the default s key
    ["s"] = "<nop>",
    -- split the screens to horizontal (up / down) and vertical (left / right)
    ["su"] = ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>",
    ["se"] = ":set splitbelow<CR>:split<CR>",
    ["sn"] = ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>",
    ["si"] = ":set splitright<CR>:vsplit<CR>",

    -- Rotate screens
    ["sr"] = "<C-w>b<C-w>K",
    ["sR"] = "<C-w>b<C-w>H",

    -- Swap the current window with the next one
    ["sw"] = "<C-w>x",

    -- move current window to the far left, bottom, rihgt, top
    ["sN"] = "<C-w>H",
    ["sE"] = "<C-w>J",
    ["sI"] = "<C-w>L",
    ["sU"] = "<C-w>K",

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

    -- inc/dec numbers
    ["<C-=>"] = "<C-a>",
    ["<C-->"] = "<C-x>",

    ["<tab>"] = ":bnext<CR>",
    ["<s-tab>"] = ":bprevious<CR>",

    -- map backspace to ciw
    ["<BS>"] = "ciw",
    -- goto new position in jumplist
    ["<C-h>"] = "<C-i>",
  },
  ["v"] = {
    -- copy to system clipboard
    ["Y"] = '"+y',

    -- Better indenting
    ["<"] = "<gv",
    [">"] = ">gv",

    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-e>"] = ":m '>+1<CR>gv-gv",
    ["<A-u>"] = ":m '<-1<CR>gv-gv",

    -- inc/dec numbers
    ["<C-=>"] = "<C-a>",
    ["<C-->"] = "<C-x>",

    -- Column inc/dec numbers
    ["g<C-=>"] = "g<C-a>",
    ["g<C-->"] = "g<C-x>",
  },
  ["x"] = {
    -- Move current line / block with Alt-e/u ala vscode.
    ["<A-e>"] = ":m '>+1<CR>gv-gv",
    ["<A-u>"] = ":m '<-2<CR>gv-gv",

    -- select all
    ["<C-a>"] = "<Esc>ggVG",
    -- replace in selection
    ["s"] = ":s/\\%V",
  },
  ["t"] = {
    -- Terminal window navigation
    ["<C-n>"] = "<C-\\><C-N><C-w>h",
    ["<C-e>"] = "<C-\\><C-N><C-w>j",
    ["<C-u>"] = "<C-\\><C-N><C-w>k",
    ["<C-i>"] = "<C-\\><C-N><C-w>l",
    -- paste
    ["<C-v>"] = "<C-\\><C-N>pi",
  },
  ["c"] = {
    -- navigate tab completion with <c-e> and <c-u>
    -- runs conditionally
    ["<C-e>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
    ["<C-u>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
    -- paste
    ["<C-v>"] = "<C-r>+",
  },
}

local function set_keymaps(mode, key, val)
  local opt = general_opts[mode] or opts_any
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

vim.keymap.set("", saturn.leaderkey, "<Nop>", opts_any)
vim.g.mapleader = saturn.leaderkey
vim.g.maplocalleader = saturn.leaderkey
for mode, maps in pairs(keys) do
  for key, val in pairs(maps) do
    set_keymaps(mode, key, val)
  end
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>e.",
  "<cmd>edit .<cr>",
  { noremap = true, silent = true, desc = "Explore Current Directory" }
)

-- QuickFix
vim.api.nvim_set_keymap(
  "n",
  "<leader>qi",
  "<cmd>cnext<cr>",
  { noremap = true, silent = true, desc = "Next Quickfix Item" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>qn",
  "<cmd>cnext<cr>",
  { noremap = true, silent = true, desc = "Previous Quickfix Item" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>qt",
  "<cmd>TodoQuickFix<cr>",
  { noremap = true, silent = true, desc = "Show TODOS" }
)
