local M = {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "BufReadPost",
  enabled = saturn.enable_extra_plugins,
}

local error_red = "#F44747"
local warning_orange = "#ff8800"
-- local info_yellow = "#FFCC66"
local hint_blue = "#4FC1FF"
local perf_purple = "#7C3AED"
local note_green = "#10B981"
saturn.plugins.todo_comments = {
  signs = true, -- show saturn.icons.in the signs column
  sign_priority = 8, -- sign priority
  -- keywords recognized as todo comments
  keywords = {
    FIX = {
      icon = saturn.icons.ui.Bug, -- icon used for the sign, and in search results
      color = error_red, -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = saturn.icons.ui.Check, color = hint_blue, alt = { "TIP" } },
    HACK = { icon = saturn.icons.ui.Fire, color = warning_orange },
    WARN = { icon = saturn.icons.diagnostics.Warning, color = warning_orange, alt = { "WARNING", "XXX" } },
    PERF = {
      icon = saturn.icons.ui.Dashboard,
      color = perf_purple,
      alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "TEST" },
    },
    NOTE = { icon = saturn.icons.ui.Note, color = note_green, alt = { "INFO" } },
  },
  -- merge_keywords = true, -- when true, custom keywords will be merged with the defaults
  -- highlighting of the line containing the todo comment
  -- * before: highlights before the keyword (typically comment characters)
  -- * keyword: highlights of the keyword
  -- * after: highlights after the keyword (todo text)
  highlight = {
    before = "", -- "fg" or "bg" or empty
    -- keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
    keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
    after = "fg", -- "fg" or "bg" or empty
    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400, -- ignore lines longer than this
    exclude = { "markdown" }, -- list of file types to exclude highlighting
  },
  -- list of named colors where we try to extract the guifg from the
  -- list of hilight groups or use the hex color if hl not found as a fallback
  -- colors = {
  --   error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
  --   warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
  --   info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
  --   hint = { "LspDiagnosticsDefaultHint", "#10B981" },
  --   default = { "Identifier", "#7C3AED" },
  -- },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
}

function M.config()
  local todo_comments = require("todo-comments")
  todo_comments.setup(saturn.plugins.todo_comments)
  if saturn.plugins.todo_comments.on_config_done then
    saturn.plugins.todo_comments.on_config_done(todo_comments)
  end
end

return M
