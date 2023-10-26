return {
  {
    "codota/tabnine-nvim",
    build = "./dl_binaries.sh",
    event = "InsertEnter",
    cmd = {
      "TabnineToggle",
      "TabnineDisable",
      "TabnineEnable",
      "TabnineToggle",
      "TabnineHub",
    },
    keys = {
      {
        "<leader>at",
        "<cmd>TabnineToggle<CR>",
        desc = "TabNine Toggle",
      },
      {
        "<leader>aC",
        function()
          require("tabnine.chat").open()
        end,
        desc = "Tabnine Chat",
        mode = { "n", "x" },
      },
    },
    config = function()
      require("tabnine").setup({
        disable_auto_comment = true,
        accept_keymap = "<M-a>",
        dismiss_keymap = "<C-]>",
        debounce_ms = 800,
        suggestion_color = { gui = "#808080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt" },
        log_file_path = nil, -- absolute path to Tabnine log file
      })
    end,
  },
}
