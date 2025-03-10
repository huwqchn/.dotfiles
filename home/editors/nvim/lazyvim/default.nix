{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.my.neovim.lazyvim;

  pluginsOptionType = let
    inherit (lib.types) listOf oneOf package str submodule;
  in
    listOf (oneOf [
      package
      (submodule {
        options = {
          name = mkOption {type = str;};
          path = mkOption {type = package;};
        };
      })
    ]);
in {
  imports = [./config.nix ./plugins];

  options.my.neovim.lazyvim = {
    enable = mkEnableOption "LazyVim" // {default = config.my.neovim.enable;};

    plugins =
      # let
      #   LazyVim = pkgs.vimUtils.buildVimPlugin {
      #     pname = "LazyVimNG";
      #     version = "2025-02-15";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "LazyVim";
      #       repo = "LazyVim";
      #       rev = "3f034d0a7f58031123300309f2efd3bb0356ee21";
      #       sha256 = "sha256-1q8c2M/FZxYg4TiXe9PK6JdR4wKBgPbxRt40biIEBaY=";
      #     };
      #     doCheck = false;
      #     meta.homepage = "https://github.com/LazyVim/LazyVim/";
      #     meta.hydraPlatforms = [];
      #   };
      # in
      mkOption {
        type = pluginsOptionType;
        default = with pkgs.vimPlugins; [
          ############
          # init.lua #
          ############
          LazyVim
          # {
          #   name = "LazyVim";
          #   path = LazyVim;
          # }
          snacks-nvim

          ##############
          # coding.lua #
          ##############

          # auto pairs
          {
            name = "mini.pairs";
            path = mini-nvim;
          }
          # comments
          ts-comments-nvim
          # Better text-objects
          {
            name = "mini.ai";
            path = mini-nvim;
          }
          lazydev-nvim

          ###################
          # colorscheme.lua #
          ###################

          tokyonight-nvim
          {
            name = "catppuccin";
            path = catppuccin-nvim;
          }

          ##############
          # editor.lua #
          ##############

          grug-far-nvim
          flash-nvim
          which-key-nvim
          gitsigns-nvim
          trouble-nvim
          todo-comments-nvim

          ##################
          # formatting.lua #
          ##################

          conform-nvim

          ###############
          # linting.lua #
          ###############

          nvim-lint

          ##################
          # treesitter.lua #
          ##################

          nvim-treesitter
          nvim-treesitter-textobjects
          nvim-ts-autotag

          ##########
          # ui.lua #
          ##########

          bufferline-nvim
          lualine-nvim
          noice-nvim
          {
            name = "mini.icons";
            path = mini-nvim;
          }
          nui-nvim
          snacks-nvim

          #######
          # lsp #
          #######

          nvim-lspconfig
        ];
      };

    cmp = mkOption {
      type = types.enum ["nivm-cmp" "blink.cmp" "auto"];
      default = "auto";
      description = ''
        choose the completion engine
        if you choose "auto", it will use the lazyVim default completion engine
      '';
    };

    picker = mkOption {
      type = types.enum ["telescope" "fzf" "snacks" "auto"];
      default = "auto";
      description = ''
        choose the picker engine
        if you choose "auto", it will use the lazyVim default picker engine
      '';
    };

    explorer = mkOption {
      type = types.enum ["neo-tree" "snacks" "auto"];
      default = "auto";
      description = ''
        choose the file explorer
        if you choose "auto", it will use the lazyVim default file explorer
      '';
    };

    extraPlugins = mkOption {
      type = pluginsOptionType;
      default = [];
    };

    excludePlugins = mkOption {
      type = pluginsOptionType;
      default = [];
    };

    extraSpec = mkOption {
      type = types.lines;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      extraPackages = with pkgs; [
        # LazyVim
        lua
        lua-language-server
        stylua
        vscode-langservers-extracted
        fd
      ];

      plugins = with pkgs.vimPlugins; [lazy-nvim];

      extraLuaConfig = let
        mkEntryFromDrv = drv:
          if lib.isDerivation drv
          then {
            name = "${lib.getName drv}";
            path = drv;
          }
          else drv;

        lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv
          (lib.subtractLists cfg.excludePlugins cfg.plugins
            ++ cfg.extraPlugins));
      in ''
        vim.g.lazyvim_cmp = "${cfg.cmp}"
        vim.g.lazyvim_picker = "${cfg.picker}"
        vim.g.lazyvim_explorer = "${cfg.explorer}"
        vim.g.lazyvim_check_order = false
        require("lazy").setup({
          change_detection = { notify = false },
          defaults = {
            lazy = true,
            version = false
          },
          ui = { border = "rounded" },
          dev = {
            path = "${lazyPath}",
            patterns = { "" },
            fallback = true,
          },
          checker = { enabled = false },
          rocks = {
            enabled = false,
          },
          performance = {
            cache = {
              enabled = true,
            },
            rtp = {
              disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
              },
            },
          },
          spec = {
            { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            ${cfg.extraSpec}
            { import = "plugins" },
            -- The following configs are needed for fixing lazyvim on nix
            -- disable mason.nvim, use programs.neovim.extraPackages
            { "williamboman/mason-lspconfig.nvim", enabled = false },
            { "williamboman/mason.nvim", enabled = false },
            -- import/override with your plugins
            -- treesitter handled by my.neovim.treesitterParsers, put this line at the end of spec to clear ensure_installed
            { "nvim-treesitter/nvim-treesitter", opts = function(_, opts) opts.ensure_installed = {} end },
          },
        })
      '';
    };

    my.neovim.treesitterParsers = ["jsonc" "regex"];
  };
}
