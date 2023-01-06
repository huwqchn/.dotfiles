local M = {}

saturn.plugins.whichkey = {
  ---@usage disable which-key completely [not recommended]
  active = true,
  on_config_done = nil,
  setup = {
    plugins = {
      marks = false, -- shows a list of your marks on ' and `
      registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false, -- default bindings on <c-w>
        nav = false, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
      spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
    },
    key_labels = {
      -- OVERRIDE THE LABEL USED TO DISPLAY SOME KEYS. iT DOESN'T EFFECT wk IN ANY OTHER WAY.
      -- fOR EXAMPLE:
      ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    icons = {
      breadcrumb = saturn.icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
      separator = saturn.icons.ui.BoldArrowRight, -- symbol used between a key and it's label
      group = saturn.icons.ui.Plus, -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-e>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
      border = "rounded", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "center", -- align columns left, center or right
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "u", "e" },
      v = { "u", "e" },
    },
    -- disable the WhichKey popup for certain buf types and file types.
    -- Disabled by deafult for Telescope
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  },

  opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  },
  vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  },
  -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
  -- see https://neovim.io/doc/user/map.html#:map-cmd
  vmappings = {
    -- ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
    s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
  },
  mappings = {
    c = {
      name = "Code",
    },
    f = {
      name = "Files",
      f = {
        function()
          require("saturn..telescope.custom-finders").find_project_files({ previewer = false })
        end,
        "Find File",
      },
      -- f = { "<cmd>Telescope find_files<CR>", "Find File" },
      a = { "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>", "find all" },
      o = { "<cmd>Telescope file_browser<CR>", "File browser" },
      l = { "<cmd>Lf<CR>", "Open LF" },
      r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
      z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
    },
    l = {
      name = "LSP",
      a = { vim.lsp.buf.code_action, "Code Action" },
      c = { "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<cr>", "Get Capabilities" },
      d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
      D = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
      -- c = { "<cmd>lua require('user.lsp').server_capabilities()<cr>", "Get Capabilities" },
      -- d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
      w = {
        "<cmd>Telescope lsp_workspace_diagnostics<cr>",
        "Workspace Diagnostics",
      },
      -- f = { require("saturn..lsp.utils").format, "Format" },
      f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
      F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>Mason<cr>", "Mason Info" },
      h = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle Hints" },
      H = { "<cmd>IlluminationToggle<cr>", "Toggle Doc HL" },
      e = {
        vim.diagnostic.goto_next,
        "Next Diagnostic",
      },
      u = {
        vim.diagnostic.goto_prev,
        "Prev Diagnostic",
      },
      v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Virtual Text" },
      -- v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Virtual Text" },
      l = { vim.lsp.codelens.run, "CodeLens Action" },
      o = { vim.diagnostic.open_float, "Show in float" },
      q = { vim.diagnostic.setloclist, "Quickfix" },
      Q = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
      r = { vim.lsp.buf.rename, "Rename" },
      R = { vim.lsp.buf.references, "References" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "Workspace Symbols",
      },
      -- t = { '<cmd>lua require("user.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
      -- p = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
    },
    q = {
      name = "Quickfix",
    },
    s = {
      name = "Search",
      -- b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
      -- f = { "<cmd>Telescope find_files<cr>", "Find File" },
      h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
      s = { "<cmd>Telescope grep_string<cr>", "Find String" },
      m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      t = { "<cmd>Telescope live_grep<cr>", "Text" },
      i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      l = { "<cmd>Telescope resume<cr>", "Last Search" },
      C = { "<cmd>Telescope commands<cr>", "Commands" },
      p = {
        "<cmd>lua require('telescope.plugins').colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview",
      },
    },
    t = {
      name = "Tabs",
      t = { "<cmd>:tabnew<CR>", "New tab" },
      s = { "<cmd>:tab split<CR>", "New and move the tab" },
      x = { "<cmd>:tabclose<CR>", "Close tab" },
      n = { "<cmd>:tabn<CR>", "Go to next tab" },
      i = { "<cmd>:tabp<CR>", "Go to previous tab" },
      N = { "<cmd>:-tabmove<CR>", "Move the tab to left" },
      I = { "<cmd>:+tabmove<CR>", "Move the tab to right" },
      o = { "<cmd>:tabonly<CR>", "Close all other tabs" },
      a = { "<cmd>:tabfirst<CR>", "Go to first tab" },
      z = { "<cmd>:tablast<CR>", "Go to last tab" },
      A = { "<cmd>:tabm 0<CR>", "Move to first tab" },
      Z = { "<cmd>:tabm<CR>", "Move to last tab" },
      l = { "<cmd>:tabs<CR>", "List all tabs" },
      f = {
        "<cmd>lua require('telescope').extensions['telescope-tabs'].list_tabs(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal', prompt_title='Tabs'})<cr>",
        "Find Tab",
      },
    },
    T = {
      name = "Treesitter",
      i = { ":TSConfigInfo<cr>", "Info" },
      I = { "<cmd>Telescope lsp_implementations<cr>", "Implementations" },
    },
    u = {
      name = "Buffer",
      u = { "<cmd>Telescope buffers<cr>", "Buffers" },
      o = { "<cmd>%bd|e#|bd#<CR>", "Close all but the current buffer" },
      x = { "<cmd>Bdelete!<CR>", "Close buffer" },
      n = { "<cmd>:bprevious<CR>", "Move Previous buffer" },
      i = { "<cmd>:bnext<CR>", "Move next buffer" },
      j = { "<cmd>BufferLinePick<CR>", "Jump" },
      f = { "<cmd>Telescope buffers previewer=false<CR>", "Find buffer" },
      --b = { "<cmd>BufferLineCyclePrev<CR>", "Previous" },
      --n = { "<cmd>BufferLineCycleNext<CR>", "Next" },
      --w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
      d = { "<cmd>BufferKiller<CR>", "Kill Buffer" },
      c = {
        "<cmd>BufferLinePickClose<CR>",
        "Pick which buffer to close",
      },
      N = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
      I = {
        "<cmd>BufferLineCloseRight<cr>",
        "Close all to the right",
      },
      D = {
        "<cmd>BufferLineSortByDirectory<cr>",
        "Sort by directory",
      },
      L = {
        "<cmd>BufferLineSortByExtension<cr>",
        "Sort by language",
      },
    },
    w = {
      name = "Window",
      a = { "<cmd>wa<CR>", "Save all" },
      q = { '<cmd>lua require("saturn.utils.functions").smart_quit()<CR>', "Quit" },
    },
    -- x = {
    --   name = "terminal",
    --   p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    --   f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    --   h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    --   v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    -- },
    -- ["/"] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', "Comment" },
  },
}

M.config = function()
  local which_key = pcall(require, "which-key")

  which_key.setup(saturn.plugins.whichkey.setup)

  local opts = saturn.plugins.whichkey.opts
  local vopts = saturn.plugins.whichkey.vopts

  local mappings = saturn.plugins.whichkey.mappings
  local vmappings = saturn.plugins.whichkey.vmappings

  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)

  which_key.register({ k = { name = "inside" }, a = { name = "around" } }, { mode = "v", preset = true })
  if saturn.plugins.whichkey.on_config_done then
    saturn.plugins.whichkey.on_config_done(which_key)
  end
end

return M
