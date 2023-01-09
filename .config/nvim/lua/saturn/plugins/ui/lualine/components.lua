local conditions = require "saturn.plugins.ui.lualine.conditions"
local colors = require "saturn.plugins.ui.lualine.colors"

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end


-- auto change color according to neovims mode
local mode_color = {
  n = colors.blue,
  i = colors.green,
  v = colors.purple,
  [''] = colors.purple,
  V = colors.purple,
  c = colors.red,
  no = colors.red,
  s = colors.orange,
  S = colors.orange,
  [''] = colors.orange,
  ic = colors.yellow,
  R = colors.violet,
  Rv = colors.violet,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ['r?'] = colors.cyan,
  ['!'] = colors.red,
  t = colors.red,
}

local function evil_mode_fg_color()
  return { fg = mode_color[vim.fn.mode()] }
end

local function evil_mode_bg_color()
  return { bg = mode_color[vim.fn.mode()], fg = colors.darkblue }
end

local branch = saturn.icons.git.Branch

return {
  mode = {
    function()
      return " " .. saturn.icons.misc.Saturn .. " "
    end,
    padding = { left = 0, right = 0 },
    color = {},
    cond = nil,
  },
  left_notch = {
    function()
      return saturn.icons.ui.ThickBoldLineLeft
    end,
    padding = { left = 0, right = 1 },
    -- color = { fg = colors.blue },
    color = evil_mode_fg_color,
  },
  right_notch = {
    function()
      return saturn.icons.ui.ThickBoldLineRight
    end,
    padding = { left = 1, right = 0 },
    -- color = { fg = colors.blue },
    color = evil_mode_fg_color,
  },
  left_inactive_notch = {
    function()
      return saturn.icons.ui.ThickBoldLineLeft
    end,
    padding = { left = 0, right = 1 },
    color = colors.violet,
  },
  right_inactive_notch = {
    function()
      return saturn.icons.ui.ThickBoldLineRight
    end,
    padding = { left = 1, right = 0 },
    color = colors.violet,
  },
  evil_mode = {
    function()
      return saturn.icons.misc.Evil
    end,
    color = evil_mode_fg_color,
    padding = { right = 1 },
  },
  evil_inactive_mode = {
    function()
      return saturn.icons.misc.Evil
    end,
    color = colors.violet,
    padding = { right = 1 },
  },
  evil_diff = {
    "diff",
    symbols = {
      added = saturn.icons.git.LineAdded .. " ",
      modified = saturn.icons.git.LineModified .. " ",
      removed = saturn.icons.git.LineRemoved .. " ",
    },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
  },
  fileicon = {
    'filetype',
    colored = true,
    icon_only = true,
    icon = { align = 'right' },
    padding = { left = 1, right = 0 },
  },
  evil_filename = {
    "filename",
    color = { fg = colors.magenta, gui = "bold" },
    cond = conditions.buffer_not_empty,
    padding = { left = 1, right = 1 },
  },
  evil_branch = {
    "branch",
    icon = branch,
    color = { fg = colors.green, gui = 'bold' },
  },
  evil_progress = {
    "progress",
    color = { fg = colors.fg, gui = "bold" },
  },
  fileformat = {
    'fileformat',
    fmt = string.upper,
    icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
    color = { fg = colors.fg, gui = 'bold' },
  },
  branch = {
    "b:gitsigns_head",
    icon = branch,
    color = { gui = "bold" },
  },
  filesize = {
    "filesize",
    cond = conditions.buffer_not_empty,
  },
  filename = {
    "filename",
    color = {},
    cond = conditions.buffer_not_empty,
  },
  diff = {
    "diff",
    source = diff_source,
    symbols = {
      added = saturn.icons.git.LineAdded .. " ",
      modified = saturn.icons.git.LineModified .. " ",
      removed = saturn.icons.git.LineRemoved .. " ",
    },
    padding = { left = 2, right = 1 },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    cond = nil,
  },
  python_env = {
    function()
      local utils = require "saturn.plugins.ui.lualine.utils"
      if vim.bo.filetype == "python" then
        local venv = os.getenv "CONDA_DEFAULT_ENV" or os.getenv "VIRTUAL_ENV"
        if venv then
          local icons = require "nvim-web-devicons"
          local py_icon, _ = icons.get_icon ".py"
          return string.format(" " .. py_icon .. " (%s)", utils.env_cleanup(venv))
        end
      end
      return ""
    end,
    color = { fg = colors.green },
    cond = conditions.hide_in_width,
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = {
      error = saturn.icons.diagnostics.BoldError .. " ",
      warn = saturn.icons.diagnostics.BoldWarning .. " ",
      info = saturn.icons.diagnostics.BoldInformation .. " ",
      hint = saturn.icons.diagnostics.BoldHint .. " ",
    },
    diagnostics_color = {
      color_error = { fg = colors.red },
      color_warn = { fg = colors.yellow },
      color_info = { fg = colors.cyan },
    },
  },
  treesitter = {
    function()
      return saturn.icons.ui.Tree
    end,
    color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
    end,
    cond = conditions.hide_in_width,
  },
  lsp = {
    function(msg)
      msg = msg or "LS Inactive"
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        -- TODO: clean up this if statement
        if type(msg) == "boolean" or #msg == 0 then
          return "LS Inactive"
        end
        return msg
      end
      local buf_ft = vim.bo.filetype
      local buf_client_names = {}
      local copilot_active = false

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" and client.name ~= "copilot" then
          table.insert(buf_client_names, client.name)
        end

        if client.name == "copilot" then
          copilot_active = true
        end
      end

      -- add formatter
      local formatters = require "saturn.plugins.lsp.null-ls.formatters"
      local supported_formatters = formatters.list_registered(buf_ft)
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local linters = require "saturn.plugins.lsp.null-ls.linters"
      local supported_linters = linters.list_registered(buf_ft)
      vim.list_extend(buf_client_names, supported_linters)

      local unique_client_names = vim.fn.uniq(buf_client_names)

      local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

      if copilot_active then
        language_servers = language_servers .. "%#SLCopilot#" .. " " .. saturn.icons.git.Octoface .. "%*"
      end

      return language_servers
    end,
    color = { gui = "bold" },
    cond = conditions.hide_in_width,
  },
  location = { "location" },
  progress = {
    "progress",
    fmt = function()
      return "%P/%L"
    end,
    color = { gui = 'bold' },
  },

  spaces = {
    function()
      local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
      return saturn.icons.ui.Tab .. " " .. shiftwidth
    end,
    padding = 1,
  },
  encoding = {
    "o:encoding",
    fmt = string.upper,
    color = {},
    cond = conditions.hide_in_width,
  },
  filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 } },
  scrollbar = {
    function()
      local current_line = vim.fn.line "."
      local total_lines = vim.fn.line "$"
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    padding = { left = 0, right = 0 },
    color = "SLProgress",
    cond = nil,
  },
}

