local M = {
  "simrat39/symbols-outline.nvim",
  enabled = saturn.enable_extra_plugins,
  keys = { { "<leader>eo", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
}

function M.config()
  saturn.plugins.symbols_outline = {
    active = true,
    on_config_done = nil,
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false,
    position = "right",
    width = 40,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    keymaps = { -- These keymaps can be a string or a table for multiple keys
      close = { "<Esc>", "q" },
      goto_location = "<Cr>",
      focus_location = "o",
      hover_symbol = "<C-k>",
      toggle_preview = "K",
      rename_symbol = "r",
      code_actions = "a",
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
    symbols = {
      File = { icon = saturn.icons.ui.File, hl = "CmpItemKindFile" },
      Module = { icon = saturn.icons.kind.Module, hl = "CmpItemKindModule" },
      Namespace = { icon = saturn.icons.kind.Module, hl = "CmpItemKindModule" },
      Package = { icon = saturn.icons.kind.Module, hl = "CmpItemKindModule" },
      Class = { icon = saturn.icons.kind.Class, hl = "CmpItemKindClass" },
      Method = { icon = saturn.icons.kind.Method, hl = "CmpItemKindMethod" },
      Property = { icon = saturn.icons.kind.Property, hl = "CmpItemKindProperty" },
      Field = { icon = saturn.icons.kind.Field, hl = "CmpItemKindField" },
      Constructor = { icon = saturn.icons.kind.Constructor, hl = "CmpItemKindConstructor" },
      Enum = { icon = saturn.icons.kind.Enum, hl = "CmpItemKindEnum" },
      Interface = { icon = saturn.icons.kind.Interface, hl = "CmpItemKindInterface" },
      Function = { icon = saturn.icons.kind.Function, hl = "CmpItemKindFunction" },
      Variable = { icon = saturn.icons.kind.Variable, hl = "CmpItemKindVariable" },
      Constant = { icon = saturn.icons.kind.Constant, hl = "CmpItemKindConstant" },
      String = { icon = saturn.icons.kind.String, hl = "TSString" },
      Number = { icon = saturn.icons.kind.Number, hl = "TSNumber" },
      Boolean = { icon = saturn.icons.kind.Boolean, hl = "TSBoolean" },
      Array = { icon = saturn.icons.kind.Array, hl = "TSKeyword" },
      Object = { icon = saturn.icons.kind.Object, hl = "TSKeyword" },
      Key = { icon = saturn.icons.kind.Keyword, hl = "CmpItemKeyword" },
      Null = { icon = "NULL", hl = "TSKeyword" },
      EnumMember = { icon = saturn.icons.kind.EnumMember, hl = "CmpItemKindEnumMember" },
      Struct = { icon = saturn.icons.kind.Struct, hl = "CmpItemKindStruct" },
      Event = { icon = saturn.icons.kind.Event, hl = "CmpItemKindEvent" },
      Operator = { icon = saturn.icons.kind.Operator, hl = "CmpItemKindOperator" },
      TypeParameter = { icon = saturn.icons.kind.TypeParameter, hl = "CmpItemKindTypeParameter" },
    },
  }
  require("symbols_outline").setup(saturn.plugins.symbols_outline)
end

return M
