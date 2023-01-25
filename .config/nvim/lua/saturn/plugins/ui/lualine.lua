local colors = {
  red = "#cdd6f4",
  grey = "#181825",
  black = "#1e1e2e",
  white = "#313244",
  light_green = "#6c7086",
  orange = "#fab387",
  green = "#a6e3a1",
  blue = "#80A7EA",
}

local window_width_limit = 100

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.o.columns > window_width_limit
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local theme = {
  normal = {
    a = { fg = colors.black, bg = colors.blue },
    b = { fg = colors.blue, bg = colors.white },
    c = { fg = colors.white, bg = colors.black },
    z = { fg = colors.white, bg = colors.black },
  },
  insert = { a = { fg = colors.black, bg = colors.orange } },
  visual = { a = { fg = colors.black, bg = colors.green } },
  replace = { a = { fg = colors.black, bg = colors.green } },
}

local vim_icons = {
  function()
    return saturn.icons.misc.Saturn
  end,
  separator = { left = saturn.icons.ui.SeparatorLeft, right = saturn.icons.ui.SeparatorRight },
  color = { bg = "#313244", fg = "#80A7EA" },
}

local space = {
  function()
    return " "
  end,
  color = { bg = colors.black, fg = "#80A7EA" },
}

local filename = {
  "filename",
  color = { bg = "#80A7EA", fg = "#242735" },
  separator = { left = saturn.icons.ui.SeparatorLeft, right = saturn.icons.ui.SeparatorRight },
  cond = conditions.hide_in_width,
}

local filetype = {
  "filetype",
  icon_only = true,
  colored = true,
  color = { bg = "#313244" },
  separator = { left = saturn.icons.ui.SeparatorLeft, right = saturn.icons.ui.SeparatorRight },
}

local fileformat = {
  "fileformat",
  color = { bg = "#b4befe", fg = "#313244" },
  separator = { left = saturn.icons.ui.SeparatorLeft, right = saturn.icons.ui.SeparatorRight },
}

local encoding = {
  "encoding",
  color = { bg = "#313244", fg = "#80A7EA" },
  separator = { left = saturn.icons.ui.SeparatorLeft, right = saturn.icons.ui.SeparatorRight },
}

local branch = {
  "branch",
  icon = saturn.icons.git.Branch,
  color = { bg = "#a6e3a1", fg = "#313244" },
  separator = { left = saturn.icons.ui.SeparatorLeft, right = saturn.icons.ui.SeparatorRight },
}

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

local diff = {
  "diff",
  source = diff_source,
  symbols = {
    added = saturn.icons.git.LineAdded .. " ",
    modified = saturn.icons.git.LineModified .. " ",
    removed = saturn.icons.git.LineRemoved .. " ",
  },
  padding = { left = 2, right = 1 },
  color = { bg = "#313244", fg = "#313244" },
  separator = { left = saturn.icons.ui.SeparatorLeft, right = saturn.icons.ui.SeparatorRight },
}

local modes = {
  "mode",
  fmt = function(str)
    return str:sub(1, 1)
  end,
  color = { bg = "#fab387", fg = "#1e1e2e" },
  separator = { left = saturn.icons.ui.SeparatorLeft, right = saturn.icons.ui.SeparatorRight },
}

local function getLspName()
  local msg = "No Active Lsp"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return saturn.icons.ui.MultiGear .. " " .. client.name
    end
  end
  return saturn.icons.ui.MultiGear .. " " .. msg
end

local dia = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    error = saturn.icons.diagnostics.BoldError .. " ",
    warn = saturn.icons.diagnostics.BoldWarning .. " ",
    info = saturn.icons.diagnostics.BoldInformation .. " ",
    hint = saturn.icons.diagnostics.BoldHint .. " ",
  },
  color = { bg = "#313244", fg = "#80A7EA" },
  separator = { left = saturn.icons.ui.SeparatorLeft, right = saturn.icons.ui.SeparatorRight },
}

local lsp = {
  function()
    return getLspName()
  end,
  separator = { left = saturn.icons.ui.SeparatorLeft, right = saturn.icons.ui.SeparatorRight },
  color = { bg = "#f38ba8", fg = "#1e1e2e" },
}

local lazy = {
  require("lazy.status").updates,
  cond = require("lazy.status").has_updates,
  color = { bg = "#a9a1e1", fg = "#202328" },
  separator = { left = saturn.icons.ui.SeparatorLeft, right = saturn.icons.ui.SeparatorRight },
}

require("lualine").setup({

  options = {
    icons_enabled = true,
    theme = theme,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },

  sections = {
    lualine_a = {
      --{ 'mode', fmt = function(str) return str:gsub(str, "  ") end },
      modes,
      vim_icons,
      --{ 'mode', fmt = function(str) return str:sub(1, 1) end },
    },
    lualine_b = {
      space,
    },
    lualine_c = {
      filename,
      filetype,
      space,
      branch,
      diff,
    },
    lualine_x = {
      lazy,
      space,
    },
    lualine_y = {
      encoding,
      fileformat,
      space,
    },
    lualine_z = {
      dia,
      lsp,
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
})
