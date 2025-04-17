return {
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-emoji" },
      { "hrsh7th/cmp-nvim-lua" },
      { "dmitmel/cmp-cmdline-history" },
      { "hrsh7th/cmp-nvim-lsp" },
    },
    keys = {
      { "<Tab>", mode = { "i", "s" } },
      { "<S-Tab>", mode = { "i", "s" } },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local neotab_ok, neotab = pcall(require, "neotab")
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
      opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
          elseif neotab_ok then
            neotab.tabout()
          else
            return fallback()
          end
        end),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
          else
            return fallback()
          end
        end),
        ["<C-e>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-i>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-c>"] = cmp.mapping.abort(),
        ["<C-x>"] = cmp.mapping.complete(),
        ["<C-Space>"] = nil,
      })
      opts.experimental = vim.tbl_extend("force", opts.experimental or {}, {
        native_menu = false,
      })
      opts.completion = vim.tbl_extend("force", opts.completion or {}, {
        ---@usage The minimum length of a word to complete on.
        keyword_length = 1,
      })
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "emoji" },
        { name = "nvim_lua" },
        { name = "treesitter" },
        { name = "tmux" },
      }))
    end,
  },
}
