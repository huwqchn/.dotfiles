local M = {}

M.config = {
  -- size can be a number or function which is passed the current terminal
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true, -- close the terminal window when the process exits
  direction = "float", -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    -- The border key is *almost* the same as 'nvim_win_open'
    -- see :h nvim_win_open for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    border = "curved",
    -- width = <value>,
    -- height = <value>,
    winblend = 0,
    highlight = {
      border = "Normal",
      backgrounds = "Normal",
    },
  },
  -- Add executables on the config.lua
  -- { exec, keymap, description, direction, size }
  -- saturn.plugins.toggleterm.execs = {...} to overwrite
  -- saturn.plugins.toggleterm.execs[#saturn.plugins.toggleterm.execs+1] = {"gdb", "tg", "GNU Debugger"}
  -- TODO: pls add mappings in which key and refactor this
  execs = {
    { nil, "<M-S-1>", "Horizontal Terminal", "horizontal", 0.3 },
    { nil, "<M-S-2>", "Vertical Terminal", "vertical", 0.4 },
    { nil, "<M-S-3>", "Float Terminal", "float", nil },
  },
}

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
M.get_dynamic_terminal_size = function(direction, size)
  size = size or M.config.size
  if direction ~= "float" and tostring(size):find(".", 1, true) then
    size = math.min(size, 1.0)
    local buf_sizes = get_buf_size()
    local buf_size = direction == "horizontal" and buf_sizes.height or buf_sizes.width
    return buf_size * size
  else
    return size
  end
end

M.add_exec = function(opts)
  local binary = opts.cmd:match("(%S+)")
  if vim.fn.executable(binary) ~= 1 then
    vim.notify("Skipping configuring executable " .. binary .. ". Please make sure it is installed properly.")
    return
  end

  vim.keymap.set({ "n", "t" }, opts.keymap, function()
    M._exec_toggle({ cmd = opts.cmd, count = opts.count, direction = opts.direction, size = opts.size() })
  end, { desc = opts.label, noremap = true, silent = true })
end

M._exec_toggle = function(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new({ cmd = opts.cmd, count = opts.count, direction = opts.direction })
  term:toggle(opts.size, opts.direction)
end

M.lazygit_toggle = function()
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

return M
