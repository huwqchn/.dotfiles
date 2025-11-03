return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
    },
    ft = { "quarto", "qmd" },
    opts = {
      lspFeatures = {
        enabled = true,
        chunks = "curly",
      },
      codeRunner = {
        enabled = true,
        default_method = "slime",
      },
    },
  },
  {
    "jmbuhr/otter.nvim",
    ft = { "quarto", "qmd" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      buffers = {
        set_filetype = true,
      },
    },
  },
  { -- send code from python/r/qmd documets to a terminal or REPL
    -- like ipython, R, bash
    "jpalardy/vim-slime",
    ft = { "quarto", "qmd" },
    init = function()
      vim.b["quarto_is_python_chunk"] = false
      Quarto_is_in_python_chunk = function()
        require("otter.tools.functions").is_otter_language_context("python")
      end

      vim.cmd([[
       let g:slime_dispatch_ipython_pause = 100
       function SlimeOverride_EscapeText_quarto(text)
       call v:lua.Quarto_is_in_python_chunk()
       if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
       return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
       else
       if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
       return [a:text, "\n"]
       else
       return [a:text]
       end
       end
       endfunction
       ]])

      vim.g.slime_target = "neovim"
      vim.g.slime_no_mappings = true
      vim.g.slime_python_ipython = 1
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = true
    end,
    keys = {
      {
        "<leader>mm",
        function()
          local job_id = vim.b.terminal_job_id
          vim.print("job_id: " .. job_id)
        end,
        desc = "mark terminal",
      },
      {
        "<leader>ms",
        function()
          vim.fn.call("slime#config", {})
        end,
        desc = "set terminal",
      },
    },
  },
  { -- directly open ipynb files as quarto docuements
    -- and convert back behind the scenes
    "GCBallesteros/jupytext.nvim",
    ft = { "quarto", "qmd" },
    opts = {
      custom_language_formatting = {
        python = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
        r = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
      },
    },
  },
  { -- paste an image from the clipboard or drag-and-drop
    "HakonHarnes/img-clip.nvim",
    event = "BufEnter",
    ft = { "quarto", "qmd" },
    keys = {
      { "<leader>mp", "<cmd>PasteImage<cr>", desc = "insert [i]mage from clipboard" },
    },
    opts = {
      default = {
        dir_path = "img",
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
        quarto = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
  },
}
