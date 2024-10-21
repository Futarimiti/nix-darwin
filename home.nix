# https://nix-community.github.io/home-manager/options.xhtml
let
  neovim = true;
in
neovim-nightly-overlay:
{ lib, pkgs, ... }:
{
  home.stateVersion = "24.05";

  home.packages = [ ];

  home.file = {
    cvsignore = {
      source = ./scm/cvsignore;
      target = ".cvsignore";
    };
    gitconfig = {
      source = ./scm/gitconfig;
      target = ".gitconfig";
    };
    tmux = {
      source = ./tmux/tmux.conf;
      target = ".tmux.conf";
    };
    stack-config = {
      source = ./haskell/stack/config.yaml;
      target = ".stack/config.yaml";
    };
  };

  xdg.enable = true;
  xdg.configFile = {
    neovim = {
      enable = neovim;
      target = "nvim";
      source = ./neovim;
    };
    stylua.source = ./stylua;
    mpv.source = ./mpv;
    latexmk.source = ./tex/latexmk;
    latexindent.source = ./tex/latexindent;
    mutt.source = ./mutt/secrets;
    mu.source = ./mu;
    json-fmt.source = ./json-fmt;
    stylish-haskell.source = ./haskell/stylish-haskell;
    ghc = {
      recursive = true;
      source = ./haskell/ghc;
    };
    neovide.source = ./neovide;
    cabal.source = ./haskell/cabal;
    yabai.source = ./yabai;
    skhd.source = ./skhd;
  };

  programs.neovim = {
    enable = neovim;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
    defaultEditor = true;
    withRuby = false;
    extraPackages = with pkgs; [
      # oil
      darwin.trash
      # fugitive
      git
      # TS
      tree-sitter
      nodejs_22

      lua-language-server
      pyright
      texlab
      autojump # need source autojump script
      stylish-haskell
      yamlfmt
      stack
      ripgrep
      rustfmt
    ];
    plugins =
      with pkgs.vimPlugins;
      [
        vim-fugitive
        vim-rhubarb
        vim-surround
        vim-dispatch
        oil-nvim
        nvim-treesitter # only for query collection
        # nvim-treesitter-textobjects

        # experimenting
        vim-speeddating
        vim-abolish
        vim-tbone
        vim-repeat
        vim-dadbod
        vim-dadbod-ui
        vim-dadbod-completion
        # vimtex
      ]
      ++ [
        (pkgs.vimUtils.buildVimPlugin {
          name = "quicker-nvim";
          src = pkgs.fetchFromGitHub {
            owner = "stevearc";
            repo = "quicker.nvim";
            rev = "v1.1.1";
            hash = "sha256-l2M4uVuQ+NW/Nf6fwGlBUqKiWzTld/tePMPMqk3W/oM=";
          };
        })
        (pkgs.vimUtils.buildVimPlugin {
          name = "YankAssassin-vim";
          src = pkgs.fetchFromGitHub {
            owner = "svban";
            repo = "YankAssassin.vim";
            rev = "55ce478a08333c086bcccdf087453085f85854d4";
            hash = "sha256-xuQ60dTv+GjU904SB+Nt3tclbNsOycZurdtYZWciD3A=";
          };
        })
        (pkgs.vimUtils.buildVimPlugin {
          name = "cmdalias-vim";
          src = pkgs.fetchFromGitHub {
            owner = "vim-scripts";
            repo = "cmdalias.vim";
            rev = "3.0";
            hash = "sha256-TMo/b2ESYQ0TxcufmpXjRfwFLPGxi0oAaYHV9lddZPg=";
          };
        })
        (pkgs.vimUtils.buildVimPlugin {
          name = "ghci-nvim";
          src = pkgs.fetchFromGitHub {
            owner = "Futarimiti";
            repo = "ghci.nvim";
            rev = "unstable";
            hash = "sha256-C07TkPevpe3rj3TAdwe8jfx249Tcjcymrs0sz3p/Jco=";
          };
        })
      ]
      ++ (with pkgs.vimPlugins.nvim-treesitter-parsers; [
        rust
        comment
        latex
        nix
        dhall
        yaml
        toml
        java # builtin one pretty much outdated
        python
        # broken shipped parsers
        bash
        query
        vimdoc
        # haskell & injections
        haskell
        css
        html
        javascript
        typescript
        json
        sql
        haskell_persistent
      ]);
  };

  programs.home-manager.enable = true;
}
