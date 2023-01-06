local M = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  config = function()
    require("saturn.plugins.telescope").config()
  end,
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      bulid = "make",
    },
    {
      "LukasPietzschmann/telescope-tabs",
      enabled = saturn.enable_extra_plugins,
    },
    {
      "nvim-telescope/telescope-media-files.nvim",
      enabled = saturn.enable_extra_plugins,
    },
    {
      "tom-anders/telescope-vim-bookmarks.nvim",
      enabled = saturn.enable_extra_plugins,
    },
  },
  cmd = "Telescope",
}

---@alias telescope_themes
---| "cursor"   # see `telescope.themes.get_cursor()`
---| "dropdown" # see `telescope.themes.get_dropdown()`
---| "ivy"      # see `telescope.themes.get_ivy()`
---| "center"   # retain the default telescope theme

-- Define this minimal config so that it's available if telescope is not yet available.
saturn.plugins.telescope = {
  ---@usage disable telescope completely [not recommended]
  active = true,
  on_config_done = nil,
}

local present, actions = pcall(require, "telescope.actions")
if not present then
  return
end
saturn.plugins.telescope = {
  active = true,
  on_config_done = nil,
  theme = "dropdown", ---@type telescope_themes
  defaults = {
    prompt_prefix = saturn.icons.ui.Telescope .. " ",
    selection_caret = saturn.icons.ui.Forward .. " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = nil,
    layout_strategy = nil,
    layout_config = nil,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git/",
    },
    ---@usage Mappings are fully customizable. Many familiar mapping patterns are setup as defaults.
    mappings = {
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<C-e>"] = actions.cycle_history_next,
        ["<C-u>"] = actions.cycle_history_prev,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<CR>"] = actions.select_default,
      },
      n = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
    file_ignore_patterns = {},
    path_display = { "smart" },
    winblend = 0,
    border = {},
    borderchars = nil,
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      --@usage don't include the filename in the search results
      only_sort_text = true,
    },
    grep_string = {
      only_sort_text = true,
    },
    buffers = {
      initial_mode = "normal",
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
        },
      },
    },
    planets = {
      show_pluto = true,
      show_moon = true,
    },
    git_files = {
      hidden = true,
      show_untracked = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
}

function M.config()
  saturn.plugins.telescope.defaults.file_ignore_patterns = {
    ".git/",
    "target/",
    "docs/",
    "vendor/*",
    "%.lock",
    "__pycache__/*",
    "%.sqlite3",
    "%.ipynb",
    "node_modules/*",
    -- "%.jpg",
    -- "%.jpeg",
    -- "%.png",
    "%.svg",
    "%.otf",
    "%.ttf",
    "%.webp",
    ".dart_tool/",
    ".github/",
    ".gradle/",
    ".idea/",
    ".settings/",
    ".vscode/",
    "__pycache__/",
    "build/",
    "env/",
    "gradle/",
    "node_modules/",
    "%.pdb",
    "%.dll",
    "%.class",
    "%.exe",
    "%.cache",
    "%.ico",
    "%.pdf",
    "%.dylib",
    "%.jar",
    "%.docx",
    "%.met",
    "smalljre_*/*",
    ".vale/",
    "%.burp",
    "%.mp4",
    "%.mkv",
    "%.rar",
    "%.zip",
    "%.7z",
    "%.tar",
    "%.bz2",
    "%.epub",
    "%.flac",
    "%.tar.gz",
  }
  local _, actions = pcall(require, "telescope.actions")
  saturn.plugins.telescope.defaults.mappings = {
    -- for input mode
    i = {
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,

      ["<C-e>"] = actions.move_selection_next,
      ["<C-u>"] = actions.move_selection_previous,

      ["<C-b>"] = actions.results_scrolling_up,
      ["<C-f>"] = actions.results_scrolling_down,

      ["<C-c>"] = actions.close,

      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,

      ["<CR>"] = actions.select_default,
      ["<C-s>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,

      ["<c-d>"] = require("telescope.actions").delete_buffer,

      -- ["<C-u>"] = actions.preview_scrolling_up,
      -- ["<C-d>"] = actions.preview_scrolling_down,

      -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<Tab>"] = actions.close,
      ["<S-Tab>"] = actions.close,
      -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      ["<C-l>"] = actions.complete_tag,
      ["<C-h>"] = actions.which_key, -- keys from pressing <C-h>
      ["<esc>"] = actions.close,
    },
    -- for normal mode
    n = {
      ["<esc>"] = actions.close,
      ["<CR>"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,
      ["<C-b>"] = actions.results_scrolling_up,
      ["<C-f>"] = actions.results_scrolling_down,

      ["<Tab>"] = actions.close,
      ["<S-Tab>"] = actions.close,
      -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
      -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

      ["e"] = actions.move_selection_next,
      ["u"] = actions.move_selection_previous,
      ["U"] = actions.move_to_top,
      ["M"] = actions.move_to_middle,
      ["E"] = actions.move_to_bottom,
      ["q"] = actions.close,
      ["dd"] = require("telescope.actions").delete_buffer,
      ["s"] = actions.select_horizontal,
      ["v"] = actions.select_vertical,
      ["t"] = actions.select_tab,

      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,
      ["gg"] = actions.move_to_top,
      ["G"] = actions.move_to_bottom,

      ["<C-u>"] = actions.preview_scrolling_up,
      ["<C-d>"] = actions.preview_scrolling_down,

      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,

      ["?"] = actions.which_key,
    },
  }

  require("telescope-tabs").setup({
    show_preview = false,
    close_tab_shortcut = "C-d",
    initial_mode = "normal",
    theme = "dropdown",
    -- Your custom config :^)
  })

  -- local previewer = require("telescope.previewer")
  -- local sorters = require("telescope.sorters")

  -- saturn.plugins.telescope = vim.tbl_extend("keep", {
  --   file_previewer = previewer.vim_buffer_cat.new,
  --   grep_previewer = previewer.vim_buffer_vimgrep.new,
  --   qflist_previewer = previewer.vim_buffer_qflist.new,
  --   file_sorter = sorters.get_fuzzy_file,
  --   generic_sorter = sorters.get_generic_fuzzy_sorter,
  -- }, saturn.plugins.telescope)

  local telescope = require("telescope")

  local theme = require("telescope.themes")["get_" .. saturn.plugins.telescope.theme]
  if theme then
    saturn.plugins.telescope.defaults = theme(saturn.plugins.telescope.defaults)
  end

  telescope.setup(saturn.plugins.telescope)

  if saturn.plugins.project then
    pcall(function()
      require("telescope").load_extension("projects")
    end)
  end

  pcall(function()
    require("telescope").load_extension("harpoon")
  end)

  if saturn.plugins.telescope.on_config_done then
    saturn.plugins.telescope.on_config_done(telescope)
  end

  if saturn.plugins.telescope.extensions and saturn.plugins.telescope.extensions.fzf then
    pcall(function()
      require("telescope").load_extension("fzf")
    end)
  end
end

return M
