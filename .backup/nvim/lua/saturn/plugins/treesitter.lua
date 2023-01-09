local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    {
      "p00f/nvim-ts-rainbow",
      enabled = saturn.enable_extra_plugins and saturn.plugins.treesitter.rainbow.enable,
    },
    {
      "nvim-treesitter/playground",
      cmd = "TSPlaygroundToggle",
      enabled = saturn.enable_extra_plugins,
    },
    {
      "windwp/nvim-ts-autotag",
      event = "InsertEnter",
      enabled = saturn.enable_extra_plugins,
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      enabled = saturn.enable_extra_plugins,
    },
    {
      "nvim-treesitter/nvim-treesitter-context",
      enabled = saturn.enable_extra_plugins,
    },
    -- {
    --   "Badhi/nvim-treesitter-cpp-tools",
    --   ft = { "c", "cpp", "objc", "objcpp" },
    --   enabled = saturn.enable_extra_plugins,
    -- },
    {
      "m-demare/hlargs.nvim",
      enabled = saturn.enable_extra_plugins,
      config = {
        excluded_argnames = {
          usages = {
            lua = { "self", "use" },
          },
        },
      },
    },
  },
}

saturn.plugins.treesitter = {
  on_config_done = nil,

  ensure_installed = {}, -- put the language you want in this array
  -- ensure_installed = "all", -- one of "all" or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

  -- A directory to install the parsers into.
  -- By default parsers are installed to either the package dir, or the "site" dir.
  -- If a custom path is used (not nil) it must be added to the runtimepath.
  parser_install_dir = nil,
  -- Automatically install missing parsers when entering buffer
  auto_install = false,

  matchup = {
    enable = false, -- mandatory, false will disable the whole extension
    -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = { "markdown" },
    disable = function(lang, buf)
      if vim.tbl_contains({ "latex" }, lang) then
        return true
      end

      local status_ok, big_file_detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
      return status_ok and big_file_detected
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
  -- TODO:This indent not correct
  indent = { enable = true, disable = { "yaml", "python", "css", "c", "cpp" } },
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
    enable = false,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
}

saturn.plugins.treesitter.rainbow = {
  enable = true,
  extended_mode = false,
  colors = {
    "DodgerBlue",
    "Orchid",
    "Gold",
  },
  disable = { "html" },
}
saturn.plugins.treesitter.ensure_installed = "all"
saturn.plugins.treesitter.textobjects = {
  select = {
    enable = true,
    -- Automatically jump forward to textobj, similar to targets.vim
    lookahead = true,
    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["af"] = "@function.outer",
      ["kf"] = "@function.inner",
      ["at"] = "@class.outer",
      ["kt"] = "@class.inner",
      ["ac"] = "@call.outer",
      ["kc"] = "@call.inner",
      ["aa"] = "@parameter.outer",
      ["ka"] = "@parameter.inner",
      ["al"] = "@loop.outer",
      ["kl"] = "@loop.inner",
      ["ak"] = "@conditional.outer",
      ["kk"] = "@conditional.inner",
      ["a/"] = "@comment.outer",
      ["k/"] = "@comment.inner",
      ["ab"] = "@block.outer",
      ["kb"] = "@block.inner",
      ["as"] = "@statement.outer",
      ["ks"] = "@scopename.inner",
      ["aA"] = "@attribute.outer",
      ["kA"] = "@attribute.inner",
      ["aF"] = "@frame.outer",
      ["kF"] = "@frame.inner",
    },
  },
}

---@class bundledParsersOpts
---@field name_only boolean
---@field filter function

---Retrives a list of bundled parsers paths (any parser not found in default `install_dir`)
---@param opts bundledParsersOpts
---@return string[]
local function get_parsers(opts)
  opts = opts or {}
  opts.filter = opts.filter or function()
    return true
  end

  local bundled_parsers = vim.tbl_filter(opts.filter, vim.api.nvim_get_runtime_file("parser/*.so", true))

  if opts.name_only then
    bundled_parsers = vim.tbl_map(function(parser)
      return vim.fn.fnamemodify(parser, ":t:r")
    end, bundled_parsers)
  end

  return bundled_parsers
end

---Checks if parser is installed with nvim-treesitter
---@param lang string
---@return boolean
local function is_installed(lang)
  local configs = require("nvim-treesitter.configs")
  local result = get_parsers({
    filter = function(parser)
      local install_dir = configs.get_parser_install_dir()
      return vim.startswith(parser, install_dir) and (vim.fn.fnamemodify(parser, ":t:r") == lang)
    end,
  })
  local parser_file = result and result[1] or ""
  local stat = vim.loop.fs_stat(parser_file)
  return stat and stat.type == "file"
end

local function ensure_updated_bundled()
  local configs = require("nvim-treesitter.configs")
  local bundled_parsers = get_parsers({
    name_only = true,
    filter = function(parser)
      local install_dir = configs.get_parser_install_dir()
      return not vim.startswith(parser, install_dir)
    end,
  })

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      local missing = vim.tbl_filter(function(parser)
        return not is_installed(parser)
      end, bundled_parsers)

      if #missing > 0 then
        vim.cmd({ cmd = "TSInstall", args = missing, bang = true })
      end
    end,
  })
end

function M.config()
  local treesitter_configs = require("nvim-treesitter.configs")

  local opts = vim.deepcopy(saturn.plugins.treesitter)

  treesitter_configs.setup(opts)

  ensure_updated_bundled()

  if saturn.plugins.treesitter.on_config_done then
    saturn.plugins.treesitter.on_config_done(treesitter_configs)
  end
end

M.get_parsers = get_parsers
M.is_installed = is_installed

return M
