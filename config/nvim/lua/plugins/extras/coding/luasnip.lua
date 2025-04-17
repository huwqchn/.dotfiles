return {
  { import = "lazyvim.plugins.extras.coding.luasnip" },
  {
    "garymjr/nvim-snippets",
    enabled = false,
  },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertCharPre",
    optianal = true,
    opts = {
      enable_autosnippets = true,
      updateevents = "TextChanged,TextChangedI",
    },
    keys = {
      {
        "<C-n>",
        mode = { "i", "s" },
      },
      {
        "<C-p>",
        mode = { "i", "s" },
      },
      {
        "<M-h>",
        "<cmd>lua require'luasnip.extras.select_choice'()<cr>",
        mode = "i",
        desc = "select snippet choice",
      },
    },
    config = function(_, opts)
      local ls = require("luasnip")
      ls.config.set_config(opts)
      local user_snippets = vim.fn.stdpath("config") .. "/snippets"
      require("luasnip.loaders.from_lua").lazy_load({ paths = user_snippets })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = user_snippets })
      -- require("luasnip.loaders.from_snipmate").lazy_load()

      _G.s = ls.snippet
      _G.sn = ls.snippet_node
      _G.t = ls.text_node
      _G.i = ls.insert_node
      _G.f = ls.function_node
      _G.c = ls.choice_node
      _G.d = ls.dynamic_node
      _G.r = ls.restore_node
      _G.l = require("luasnip.extras").lambda
      _G.rep = require("luasnip.extras").rep
      _G.p = require("luasnip.extras").partial
      _G.m = require("luasnip.extras").match
      _G.n = require("luasnip.extras").nonempty
      _G.dl = require("luasnip.extras").dynamic_lambda
      _G.fmt = require("luasnip.extras.fmt").fmt
      _G.fmta = require("luasnip.extras.fmt").fmta
      _G.types = require("luasnip.util.types")
      _G.conds = require("luasnip.extras.conditions")
      _G.conds_expand = require("luasnip.extras.conditions.expand")
    end,
  },
  -- TODO: blink integration
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      ---when inside a snippet, seeks to the nearest luasnip field if possible, and checks if it is jumpable
      ---@param dir number 1 for forward, -1 for backward; defaults to 1
      ---@return boolean true if a jumpable luasnip field is found while inside a snippet
      local function jumpable(dir)
        local luasnip_ok, luasnip = pcall(require, "luasnip")
        if not luasnip_ok then
          return false
        end

        local win_get_cursor = vim.api.nvim_win_get_cursor
        local get_current_buf = vim.api.nvim_get_current_buf

        ---sets the current buffer's luasnip to the one nearest the cursor
        ---@return boolean true if a node is found, false otherwise
        local function seek_luasnip_cursor_node()
          -- TODO(kylo252): upstream this
          -- for outdated versions of luasnip
          if not luasnip.session.current_nodes then
            return false
          end

          local node = luasnip.session.current_nodes[get_current_buf()]
          if not node then
            return false
          end

          local snippet = node.parent.snippet
          local exit_node = snippet.insert_nodes[0]

          local pos = win_get_cursor(0)
          pos[1] = pos[1] - 1

          -- exit early if we're past the exit node
          if exit_node then
            local exit_pos_end = exit_node.mark:pos_end()
            if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
              snippet:remove_from_jumplist()
              luasnip.session.current_nodes[get_current_buf()] = nil

              return false
            end
          end

          node = snippet.inner_first:jump_into(1, true)
          while node ~= nil and node.next ~= nil and node ~= snippet do
            local n_next = node.next
            local next_pos = n_next and n_next.mark:pos_begin()
            local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
              or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

            -- Past unmarked exit node, exit early
            if n_next == nil or n_next == snippet.next then
              snippet:remove_from_jumplist()
              luasnip.session.current_nodes[get_current_buf()] = nil

              return false
            end

            if candidate then
              luasnip.session.current_nodes[get_current_buf()] = node
              return true
            end

            local ok
            ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
            if not ok then
              snippet:remove_from_jumplist()
              luasnip.session.current_nodes[get_current_buf()] = nil

              return false
            end
          end

          -- No candidate, but have an exit node
          if exit_node then
            -- to jump to the exit node, seek to snippet
            luasnip.session.current_nodes[get_current_buf()] = snippet
            return true
          end

          -- No exit node, exit from snippet
          snippet:remove_from_jumplist()
          luasnip.session.current_nodes[get_current_buf()] = nil
          return false
        end

        if dir == -1 then
          return luasnip.in_snippet() and luasnip.jumpable(-1)
        else
          return luasnip.in_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable(1)
        end
      end

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local cmp = require("cmp")
      local ls = require("luasnip")
      local neotab_ok, neotab = pcall(require, "neotab")
      opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
        ["<C-n>"] = cmp.mapping(function(fallback)
          if ls.choice_active() then
            ls.change_choice(1)
          elseif cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          end
          return fallback()
        end, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(function(fallback)
          if ls.choice_active() then
            ls.change_choice(-1)
          elseif cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          end
          return fallback()
        end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- this way you will only jump inside the snippet region
          elseif ls.expand_or_locally_jumpable() then
            ls.expand_or_jump()
          elseif jumpable(1) then
            ls.jump(1)
          elseif has_words_before() then
            cmp.complete()
          elseif neotab_ok then
            neotab.tabout()
          else
            return fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif ls.jumpable(-1) then
            ls.jump(-1)
          else
            return fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
