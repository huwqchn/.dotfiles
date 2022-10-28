local M = {}
local Log = require "saturn.core.log"

local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
  term_mode = { silent = true },
}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
}

---@class Keys
---@field insert_mode table
---@field normal_mode table
---@field terminal_mode table
---@field visual_mode table
---@field visual_block_mode table
---@field command_mode table

local defaults = {
  insert_mode = {
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-k>"] = "<Esc>:m .-2<CR>==gi",
    -- navigation
    ["<A-Up>"] = "<C-\\><C-N><C-w>k",
    ["<A-Down>"] = "<C-\\><C-N><C-w>j",
    ["<A-Left>"] = "<C-\\><C-N><C-w>h",
    ["<A-Right>"] = "<C-\\><C-N><C-w>l",
  },

  normal_mode = {
    -- Better window movement
    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",

    -- Resize with arrows
    ["<C-Up>"] = ":resize -2<CR>",
    ["<C-Down>"] = ":resize +2<CR>",
    ["<C-Left>"] = ":vertical resize -2<CR>",
    ["<C-Right>"] = ":vertical resize +2<CR>",

    -- Move current line / block with Alt-j/k a la vscode.
    ["<A-j>"] = ":m .+1<CR>==",
    ["<A-k>"] = ":m .-2<CR>==",

    -- QuickFix
    ["]q"] = ":cnext<CR>",
    ["[q"] = ":cprev<CR>",
    ["<C-q>"] = ":call QuickFixToggle()<CR>",
  },

  term_mode = {
    -- Terminal window navigation
    ["<C-h>"] = "<C-\\><C-N><C-w>h",
    ["<C-j>"] = "<C-\\><C-N><C-w>j",
    ["<C-k>"] = "<C-\\><C-N><C-w>k",
    ["<C-l>"] = "<C-\\><C-N><C-w>l",
  },

  visual_mode = {
    -- Better indenting
    ["<"] = "<gv",
    [">"] = ">gv",

    -- ["p"] = '"0p',
    -- ["P"] = '"0P',
  },

  visual_block_mode = {
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-j>"] = ":m '>+1<CR>gv-gv",
    ["<A-k>"] = ":m '<-2<CR>gv-gv",
  },

  command_mode = {
    -- navigate tab completion with <c-j> and <c-k>
    -- runs conditionally
    ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
    ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
  },
}

local colemak = {
  insert_mode = {
    -- Move current line / block with Alt-e/u ala vscode.
    ["<A-e>"] = "<Esc>:m .+1<CR>==gi",
    -- Move current line / block with Alt-e/u ala vscode.
    ["<A-u>"] = "<Esc>:m .-2<CR>==gi",
    -- navigation
    ["<A-Up>"] = "<C-\\><C-N><C-w>k",
    ["<A-Down>"] = "<C-\\><C-N><C-w>j",
    ["<A-Left>"] = "<C-\\><C-N><C-w>h",
    ["<A-Right>"] = "<C-\\><C-N><C-w>l",
  },

  normal_mode = {
    -- Better window movement
    ["<C-n>"] = "<C-w>h",
    ["<C-e>"] = "<C-w>j",
    ["<C-u>"] = "<C-w>k",
    ["<C-i>"] = "<C-w>l",

    -- Resize with arrows
    ["<C-Up>"] = ":resize -2<CR>",
    ["<C-Down>"] = ":resize +2<CR>",
    ["<C-Left>"] = ":vertical resize -2<CR>",
    ["<C-Right>"] = ":vertical resize +2<CR>",

    -- Move current line / block with Alt-e/u a la vscode.
    ["<A-e>"] = ":m .+1<CR>==",
    ["<A-u>"] = ":m .-2<CR>==",

    -- QuickFix
    ["]q"] = ":cnext<CR>",
    ["[q"] = ":cprev<CR>",
    ["<C-q>"] = ":call QuickFixToggle()<CR>",

    -- better command key
    [";"] = ":",

    -- press ` to change case
    ["`"] = "~",

    -- New cursor movement (the default arrow keys are used for resizing windows)
    --		 ^
    --		 u
    -- < n	 i >
    --		 e
    --		 v
    ["u"] = "k",
    ["n"] = "h",
    ["e"] = "j",
    ["i"] = "l",

    -- insert key
    ["k"] = "i",
    ["K"] = "I",

    -- remap g to t
    ["t"] = { "g", { remap = true, silent = true } },
    ["T"] = "G",

    ["gt"] = "gg",
    ["gu"] = "gk",
    ["ge"] = "ge",

    -- faster navigation
    ["U"] = "5k",
    ["E"] = "5j",

    -- go to the start/end of the line
    ["N"] = "^",
    ["I"] = "$",

    -- h -> e
    ["h"] = "e",
    ["H"] = "E",

    -- faster in-line navigation
    ["W"] = "5W",
    ["B"] = "5B",

    -- undo operations
    ["l"] = "u",
    ["L"] = "U",

    -- searching
    ["-"] = "N",
    ["="] = "n",

    -- make Y to copy till the end of the end of line
    ["Y"] = "y$",

    -- sava and quit
    ["S"] = ":w<CR>",
    ["Q"] = ":q<CR>",
  },

  term_mode = {
    -- Terminal window navigation
    ["<C-n>"] = "<C-\\><C-N><C-w>h",
    ["<C-e>"] = "<C-\\><C-N><C-w>j",
    ["<C-u>"] = "<C-\\><C-N><C-w>k",
    ["<C-i>"] = "<C-\\><C-N><C-w>l",
  },

  visual_mode = {
    -- Better indenting
    ["<"] = "<gv",
    [">"] = ">gv",

    -- paste clipboard content
    ["P"] = '"+p',

    -- copy to system clipboard
    ["Y"] = '"+y',

    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-e>"] = ":m '>+1<CR>gv-gv",
    ["<A-u>"] = ":m '<-2<CR>gv-gv",

  },

  visual_block_mode = {
    -- Move current line / block with Alt-j/k ala vscode.
    ["<A-e>"] = ":m '>+1<CR>gv-gv",
    ["<A-u>"] = ":m '<-2<CR>gv-gv",
  },

  command_mode = {
    -- navigate tab completion with <c-j> and <c-k>
    -- runs conditionally
    ["<C-e>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
    ["<C-u>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
    ["<C-n>"] = "<Left>",
    ["<C-i>"] = "<Right>",
    ["<C-h>"] = "<Home>",
    ["<C-o>"] = "<End>",
    ["<C-s>"] = "<s-Left>",
    ["<C-t>"] = "<s-Right>",
  },
}

if vim.fn.has "mac" == 1 then
  defaults.normal_mode["<A-Up>"] = defaults.normal_mode["<C-Up>"]
  defaults.normal_mode["<A-Down>"] = defaults.normal_mode["<C-Down>"]
  defaults.normal_mode["<A-Left>"] = defaults.normal_mode["<C-Left>"]
  defaults.normal_mode["<A-Right>"] = defaults.normal_mode["<C-Right>"]
  Log:debug "Activated mac keymappings"
end

-- Unsets all keybindings defined in keymaps
-- @param keymaps The table of key mappings containing a list per mode (normal_mode, insert_mode, ..)
function M.clear(keymaps)
  local default = M.get_defaults()
  for mode, mappings in pairs(keymaps) do
    local translated_mode = mode_adapters[mode] or mode
    for key, _ in pairs(mappings) do
      -- some plugins may override default bindings that the user hasn't manually overridden
      if default[mode][key] ~= nil or (default[translated_mode] ~= nil and default[translated_mode][key] ~= nil) then
        pcall(vim.keymap.del, translated_mode, key)
      end
    end
  end
end

-- Set key mappings individually
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param key The key of keymap
-- @param val Can be form as a mapping or tuple of mapping and user defined opt
function M.set_keymaps(mode, key, val)
  local opt = generic_opts[mode] or generic_opts_any
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

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
function M.load_mode(mode, keymaps)
  mode = mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do
    M.set_keymaps(mode, k, v)
  end
end

-- Load key mappings for all provided modes
-- @param keymaps A list of key mappings for each mode
function M.load(keymaps)
  keymaps = keymaps or {}
  for mode, mapping in pairs(keymaps) do
    M.load_mode(mode, mapping)
  end
end

-- Load the default keymappings
function M.load_defaults()
  M.load(M.get_defaults())
  saturn.keys = saturn.keys or {}
  for idx, _ in pairs(defaults) do
    if not saturn.keys[idx] then
      saturn.keys[idx] = {}
    end
  end
end

-- Load the colemak keymappings
function M.load_colemak()
  M.load(M.get_colemak())
  saturn.keys = saturn.keys or {}
  for idx, _ in pairs(colemak) do
    if not saturn.keys[idx] then
      saturn.keys[idx] = {}
    end
  end
end

-- Get the default keymappings
function M.get_defaults()
  return defaults
end

-- Get the colemak keymappings
function M.get_colemak()
  return colemak
end

return M
