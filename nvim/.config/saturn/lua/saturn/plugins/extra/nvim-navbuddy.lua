return {
  "SmiteshP/nvim-navbuddy",
  opts = function()
    local actions = require("nvim-navbuddy.actions")
    return {
      window = {
        border = "rounded",
      },
      mappings = {
        ["<esc>"] = actions.close, -- Close and cursor to original location
        ["q"] = actions.close,

        ["e"] = actions.next_sibling, -- down
        ["u"] = actions.previous_sibling, -- up

        ["n"] = actions.parent, -- Move to left panel
        ["o"] = actions.children, -- Move to right panel

        ["v"] = actions.visual_name, -- Visual selection of name
        ["V"] = actions.visual_scope, -- Visual selection of scope

        ["y"] = actions.yank_name, -- Yank the name to system clipboard "+
        ["Y"] = actions.yank_scope, -- Yank the scope to system clipboard "+

        ["h"] = actions.insert_name, -- Insert at start of name
        ["H"] = actions.insert_scope, -- Insert at start of scope

        ["a"] = actions.append_name, -- Insert at end of name
        ["A"] = actions.append_scope, -- Insert at end of scope

        ["r"] = actions.rename, -- Rename currently focused symbol

        ["d"] = actions.delete, -- Delete scope

        ["f"] = actions.fold_create, -- Create fold of current scope
        ["F"] = actions.fold_delete, -- Delete fold of current scope

        ["c"] = actions.comment, -- Comment out current scope

        ["<enter>"] = actions.select, -- Goto selected symbol
        ["s"] = actions.select,
      },
    }
  end,
  dependencies = {
    { "neovim/nvim-lspconfig" },
    { "SmiteshP/nvim-navic" },
    { "MunifTanjim/nui.nvim" },
  },
}
