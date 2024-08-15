return {
  {
    "jackMort/ChatGPT.nvim",
    -- event = "VeryLazy",
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTEditWithInstructions",
    },
    keys = {
      {
        "<leader>ac",
        "<cmd>ChatGPT<cr>",
        desc = "chatgpt",
      },
    },
    opts = {
      keymaps = {
        close = { "<C-c>", "<Esc>" },
        yank_last = "<C-y>",
        scroll_up = "<C-i>",
        scroll_down = "<C-e>",
        toggle_settings = "<C-o>",
        new_session = "<C-n>",
        cycle_windows = "<Tab>",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "james1236/backseat.nvim",
    cmd = {
      "Backseat",
      "BackseatAsk",
      "BackseatClear",
      "BackseatClearLine",
    },
    keys = {
      {
        "<leader>ab",
        "<cmd>Backseat<cr>",
        desc = "backseat",
      },
    },
    config = function()
      require("backseat").setup({
        -- Alternatively, set the env var $OPENAI_API_KEY by putting "export OPENAI_API_KEY=sk-xxxxx" in your ~/.bashrc
        openai_model_id = "gpt-3.5-turbo", --gpt-4 (If you do not have access to a model, it says "The model does not exist")
        -- language = 'english', -- Such as 'japanese', 'french', 'pirate', 'LOLCAT'
        -- split_threshold = 100,
        -- additional_instruction = "Respond snarkily", -- (GPT-3 will probably deny this request, but GPT-4 complies)
        -- highlight = {
        --     icon = '', -- ''
        --     group = 'Comment',
        -- }
      })
    end,
  },
}
