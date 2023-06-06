local M = {}

-- Create user defined command based on the passed collection
function M.create_user_command(collection)
  local common_opts = { force = true }
  for _, cmd in pairs(collection) do
    local opts = vim.tbl_deep_extend("force", common_opts, cmd.opts or {})
    vim.api.nvim_create_user_command(cmd.name, cmd.fn, opts)
  end
end

--- Create autocommand groups based on the passed definitions
--- Also creates the augroup automatically if it doesn't exist
---@param definitions table contains a tuple of event, opts, see `:h nvim_create_autocmd`
function M.create_autocmds(definitions)
  for _, entry in ipairs(definitions) do
    local event = entry[1]
    local opts = entry[2]
    if type(opts.group) == "string" and opts.group ~= "" then
      local exists, _ = pcall(vim.api.nvim_get_autocmds, { group = opts.group })
      if not exists then
        vim.api.nvim_create_augroup(opts.group, {})
      end
    end
    vim.api.nvim_create_autocmd(event, opts)
  end
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

function M.enable_transparent_mode()
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
      local hl_groups = {
        "Normal",
        "SignColumn",
        "NormalNC",
        "TelescopeBorder",
        "NvimTreeNormal",
        "EndOfBuffer",
        "MsgArea",
      }
      for _, name in ipairs(hl_groups) do
        vim.cmd(string.format("highlight %s ctermbg=none guibg=none", name))
      end
    end,
  })
  vim.opt.fillchars = "eob: "
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
