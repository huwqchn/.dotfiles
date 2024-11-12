return {
  {
    {
      "huggingface/hfcc.nvim",
      opts = {
        api_token = os.getenv("HF_API_KEY"),
        model = "bigcode/starcoder",
        query_params = {
          max_new_tokens = 200,
        },
      },
      keys = {
        {
          "<leader>ah",
          function()
            require("hfcc.completion").complete()
          end,
          desc = "StarCoder Completion",
        },
      },
      init = function()
        vim.api.nvim_create_user_command("StarCoder", function()
          require("hfcc.completion").complete()
        end, {})
      end,
    },
  },
}
