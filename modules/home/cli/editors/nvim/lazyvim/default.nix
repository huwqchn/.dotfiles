{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) enum lines;
  inherit (lib.modules) mkIf;
  inherit (lib.types) coercedTo listOf oneOf package str submodule;
  inherit (lib.lists) foldl';
  inherit (lib.my) sourceLua;
  extraLuaConfigs =
    foldl' (acc: path: acc // sourceLua path) {}
    cfg.config;
  cfg = config.my.neovim.lazyvim;
  pluginsOptionType = listOf (oneOf [
    package
    (submodule {
      options = {
        name = mkOption {type = str;};
        path = mkOption {type = package;};
      };
    })
  ]);
in {
  imports = lib.my.scanPaths ./.;

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
          ########
          # util #
          ########
          persistence-nvim
          plenary-nvim
        ];
      };

    cmp = mkOption {
      type = enum ["nivm-cmp" "blink.cmp" "auto"];
      default = "auto";
      description = ''
        choose the completion engine
        if you choose "auto", it will use the lazyVim default completion engine
      '';
    };

    picker = mkOption {
      type = enum ["telescope" "fzf" "snacks" "auto"];
      default = "auto";
      description = ''
        choose the picker engine
        if you choose "auto", it will use the lazyVim default picker engine
      '';
    };

    explorer = mkOption {
      type = enum ["neo-tree" "snacks" "auto"];
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

    config = mkOption {
      type = coercedTo str (path: [path]) (listOf str);
      default = [];
      description = ''
        LazyVim Lua config files (relative to `nvim/lua/plugins/extras`) that
        should be linked into `nvim/lua/plugins`. Accepts either a single string
        or a list of strings.
      '';
    };

    imports = mkOption {
      type = listOf str;
      default = [];
      description = ''
        LazyVim import modules to include in the generated spec.
      '';
    };

    extraSpec = mkOption {
      type = lines;
      default = "";
      internal = true;
      description = ''
        Additional raw Lazy spec snippets appended after `imports`.
      '';
    };

    finalExtraSpec = mkOption {
      type = lines;
      readOnly = true;
      internal = true;
      description = ''
        Derived Lazy spec snippet used during setup. Populated from `imports`
        and `extraSpec`.
      '';
    };

    extraPackages = mkOption {
      type = listOf package;
      default = [];
      example = lib.literalExpression ''
        [ pkgs.ripgrep ]
      '';
    };
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim = {
      finalExtraSpec = let
        importsSpec =
          lib.concatMapStrings (import: ''
            { import = "${import}" },
          '')
          cfg.imports;
        specPieces = lib.filter (s: s != "") [importsSpec cfg.extraSpec];
      in
        builtins.concatStringsSep "\n" specPieces;
      extraPackages = with pkgs; [
        # LazyVim essentials shipped with the wrapper
        lua
        lua-language-server
        stylua
        vscode-langservers-extracted
        fd
        fzf
        ripgrep
      ];
    };

    xdg.configFile = extraLuaConfigs;

    programs.neovim = {
      enable = true;
      inherit (cfg) extraPackages;

      plugins = with pkgs.vimPlugins; [lazy-nvim];

      extraLuaConfig = let
        mkEntryFromDrv = drv:
          if lib.isDerivation drv
          then {
            name = "${lib.getName drv}";
            path = drv;
          }
          else drv;

        lazyvimPlugins = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv
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
            path = "${lazyvimPlugins}",
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
            ${cfg.finalExtraSpec}
            { import = "plugins" },
            -- The following configs are needed for fixing lazyvim on nix
            -- disable mason.nvim, use my.neovim.lazyvim.extraPackages
            { "mason-org/mason-lspconfig.nvim", enabled = false },
            { "mason-org/mason.nvim", enabled = false },
            -- import/override with your plugins
            -- treesitter ships with all grammars via overlay; keep ensure_installed empty to skip downloads
            { "nvim-treesitter/nvim-treesitter", opts = function(_, opts) opts.ensure_installed = {} end },
          },
        })
      '';
    };
  };
}
