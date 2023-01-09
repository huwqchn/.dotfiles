local M = {
  "SmiteshP/nvim-navic",
}

function M.init()
  local icons = saturn.icons.kind

  saturn.plugins.breadcrumbs = {
    winbar_filetype_exclude = {
      "help",
      "startify",
      "dashboard",
      "packer",
      "neo-tree",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "alpha",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "Jaq",
      "harpoon",
      "dap-repl",
      "dap-terminal",
      "dapui_console",
      "dapui_hover",
      "lab",
      "Markdown",
      "notify",
      "noice",
      "",
    },
    options = {
      icons = {
        Array = icons.Array .. " ",
        Boolean = icons.Boolean,
        Class = icons.Class .. " ",
        Color = icons.Color .. " ",
        Constant = icons.Constant .. " ",
        Constructor = icons.Constructor .. " ",
        Enum = icons.Enum .. " ",
        EnumMember = icons.EnumMember .. " ",
        Event = icons.Event .. " ",
        Field = icons.Field .. " ",
        File = icons.File .. " ",
        Folder = icons.Folder .. " ",
        Function = icons.Function .. " ",
        Interface = icons.Interface .. " ",
        Key = icons.Key .. " ",
        Keyword = icons.Keyword .. " ",
        Method = icons.Method .. " ",
        Module = icons.Module .. " ",
        Namespace = icons.Namespace .. " ",
        Null = icons.Null .. " ",
        Number = icons.Number .. " ",
        Object = icons.Object .. " ",
        Operator = icons.Operator .. " ",
        Package = icons.Package .. " ",
        Property = icons.Property .. " ",
        Reference = icons.Reference .. " ",
        Snippet = icons.Snippet .. " ",
        String = icons.String .. " ",
        Struct = icons.Struct .. " ",
        Text = icons.Text .. " ",
        TypeParameter = icons.TypeParameter .. " ",
        Unit = icons.Unit .. " ",
        Value = icons.Value .. " ",
        Variable = icons.Variable .. " ",
      },
      highlight = true,
      separator = " " .. saturn.icons.ui.ChevronRight .. " ",
      depth_limit = 0,
      depth_limit_indicator = "..",
    },
  }
end

M.config = function()
  local navic = require("nvim-navic")

  M.create_winbar()
  navic.setup(saturn.plugins.breadcrumbs.options)
end

M.get_filename = function()
  local filename = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")
  local f = require("saturn.utils.functions")

  if not f.isempty(filename) then
    local file_icon, hl_group = require("nvim-web-devicons").get_icon(filename, extension, { default = true })

    if f.isempty(file_icon) then
      file_icon = saturn.icons.kind.File
    end

    local buf_ft = vim.bo.filetype

    if buf_ft == "dapui_breakpoints" then
      file_icon = saturn.icons.ui.Bug
    end

    if buf_ft == "dapui_stacks" then
      file_icon = saturn.icons.ui.Stacks
    end

    if buf_ft == "dapui_scopes" then
      file_icon = saturn.icons.ui.Scopes
    end

    if buf_ft == "dapui_watches" then
      file_icon = saturn.icons.ui.Watches
    end

    -- if buf_ft == "dapui_console" then
    --   file_icon = saturn.icons.ui.DebugConsole
    -- end

    local navic_text = vim.api.nvim_get_hl_by_name("Normal", true)
    vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text.foreground })

    return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
  end
end

local get_gps = function()
  local status_gps_ok, gps = pcall(require, "nvim-navic")
  if not status_gps_ok then
    return ""
  end

  local status_ok, gps_location = pcall(gps.get_location, {})
  if not status_ok then
    return ""
  end

  if not gps.is_available() or gps_location == "error" then
    return ""
  end

  if not require("saturn.utils.functions").isempty(gps_location) then
    return "%#NavicSeparator#" .. saturn.icons.ui.ChevronRight .. "%* " .. gps_location
  else
    return ""
  end
end

local excludes = function()
  return vim.tbl_contains(saturn.plugins.breadcrumbs.winbar_filetype_exclude or {}, vim.bo.filetype)
end

M.get_winbar = function()
  if excludes() then
    return
  end
  local f = require("saturn.utils.functions")
  local value = M.get_filename()

  local gps_added = false
  if not f.isempty(value) then
    local gps_value = get_gps()
    value = value .. " " .. gps_value
    if not f.isempty(gps_value) then
      gps_added = true
    end
  end

  if not f.isempty(value) and f.get_buf_option("mod") then
    -- TODO: replace with circle
    local mod = "%#LspCodeLens#" .. saturn.icons.ui.Circle .. "%*"
    if gps_added then
      value = value .. " " .. mod
    else
      value = value .. mod
    end
  end

  local num_tabs = #vim.api.nvim_list_tabpages()

  if num_tabs > 1 and not f.isempty(value) then
    local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
    value = value .. "%=" .. tabpage_number .. "/" .. tostring(num_tabs)
  end

  local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status_ok then
    return
  end
end

M.create_winbar = function()
  vim.api.nvim_create_augroup("_winbar", {})
  if vim.fn.has("nvim-0.8") == 1 then
    vim.api.nvim_create_autocmd(
      { "CursorHoldI", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
      {
        group = "_winbar",
        callback = function()
          if saturn.plugins.breadcrumbs.active then
            local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
            if not status_ok then
              require("saturn.plugins.breadcrumbs").get_winbar()
            end
          end
        end,
      }
    )
  end
end

return M
