return {
  -- Browser insert box use neovim
  -- TODO:not work now, need fix that
  {
    "glacambre/firenvim",
    lazy = false,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    init = function()
      if vim.g.started_by_firenvim then
        vim.g.firenvim_config = {
          localSettings = {
            [".*"] = {
              cmdline = "none",
            },
          },
        }
        vim.opt.laststatus = 0
        -- gui options
        vim.opt.guifont = "JetBrainsMonoNL Nerd Font:h26"
        vim.opt.guicursor = {
          "n-sm:block",
          "i-ci-c-ve:ver25",
          "r-cr-o-v:hor10",
          "a:blinkwait200-blinkoff500-blinkon700",
        }
        vim.api.nvim_create_autocmd("UIEnter", {
          once = true,
          callback = function()
            vim.go.lines = 20
          end,
        })

        vim.opt.guifont = "JetBrainsMonoNL Nerd Font:h26"
        vim.opt.guicursor = {
          "n-sm:block",
          "i-ci-c-ve:ver25",
          "r-cr-o-v:hor10",
          "a:blinkwait200-blinkoff500-blinkon700",
        }

        vim.cmd([[au BufEnter github.com_*.txt set filetype=markdown]])
        vim.cmd([[au BufEnter www.acwing.com_*.txt set filetype=cpp]])
        -- ignore all clangd messages
        table.insert(saturn.plugins.notify.ignore_messages, "clangd")
      end
    end,
    cond = not not vim.g.started_by_firenvim,
  },
}
