return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        keymaps = {
          toggle_package_expand = "<Space>",
          install_package = "<CR>",
          check_package_version = "c",
          check_outdated_packages = "C",
          uninstall_package = "X",
          cancel_installation = "<C-c>",
          apply_language_filter = "<C-f>",
        },
      },
    },
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    branch = "anticonceal",
    event = "LspAttach",
    opts = {},
    keys = {
      {
        "<leader>uh",
        function()
          require("lsp-inlayhints").toggle()
        end,
        desc = "Lsp Inlayhints Toggle",
      },
    },
    config = function(_, opts)
      require("lsp-inlayhints").setup(opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, args.buf)
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      local lsp_keys = require("lazyvim.plugins.lsp.keymaps")
      local keys = lsp_keys.get()
      for _, key in ipairs(keys) do
        if key[1] == "K" then
          key[1] = "I"
        elseif key[1] == "gK" then
          key[1] = "gi"
        elseif key[1] == "<c-k>" then
          key[1] = "<c-h>"
        end
      end
    end,
  },
}
