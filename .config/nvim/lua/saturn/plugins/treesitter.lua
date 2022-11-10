local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
	return
end

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local log = require 'saturn.plugins.log'
local M = {}

function M.config()
  saturn.plugins.treesitter = {
    on_config_done = nil,
    ensure_installed = { "lua", "markdown", "bash", "python", "c", "rust", "java", "cpp", "cmake" }, -- put the language you want in this array
    -- ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = {}, -- List of parsers to ignore installing
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true, -- false will disable the whole extension
      additional_vim_regex_highlighting = false,
      disable = function(lang, buf)
        if vim.tbl_contains({ "latex" }, lang) then
          return true
        end

        local max_filesize = 1024 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          if saturn.plugins.illuminate.active then
            pcall(require("illuminate").pause_buf)
          end

          vim.schedule(function()
            vim.api.nvim_buf_call(buf, function()
              vim.cmd "setlocal noswapfile noundofile"

              if vim.tbl_contains({ "json" }, lang) then
                vim.cmd "NoMatchParen"
                vim.cmd "syntax off"
                vim.cmd "syntax clear"
                vim.cmd "setlocal nocursorline nolist bufhidden=unload"

                vim.api.nvim_create_autocmd({ "BufDelete" }, {
                  callback = function()
                    vim.cmd "DoMatchParen"
                    vim.cmd "syntax on"
                  end,
                  buffer = buf,
                })
              end
            end)
          end)

          log:info "File larger than 1MB, turned off treesitter for this buffer"
          return true
        end
      end,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
      config = {
        -- Languages that have a single comment style
        typescript = "// %s",
        css = "/* %s */",
        scss = "/* %s */",
        html = "<!-- %s -->",
        svelte = "<!-- %s -->",
        vue = "<!-- %s -->",
        json = "",
      },
    },
    indent = { enable = true, disable = { "yaml", "python", "css" } },
    autotag = { enable = false },
    autopairs = { enable = true },
    textobjects = {
      swap = {
        enable = false,
        -- swap_next = textobj_swap_keymaps,
      },
      -- move = textobj_move_keymaps,
      select = {
        enable = false,
        -- keymaps = textobj_sel_keymaps,
      },
    },
    textsubjects = {
      enable = false,
      keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
    },
    playground = {
      enable = false,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
    rainbow = {
      enable = true,
      extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
      max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
    },
  }
end

function M.setup()
  -- avoid running in headless mode since it's harder to detect failures
  if #vim.api.nvim_list_uis() == 0 then
    log:debug "headless mode detected, skipping running setup for treesitter"
    return
  end

  local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    log:error "Failed to load nvim-treesitter.configs"
    return
  end

  local opts = vim.deepcopy(saturn.plugins.treesitter)

  treesitter_configs.setup(opts)

  if saturn.plugins.treesitter.on_config_done then
    saturn.plugins.treesitter.on_config_done(treesitter_configs)
  end
end

return M