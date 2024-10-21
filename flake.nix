# see :Man 5 configuration.nix
{
  description = "Carman's Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    stable.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      stable,
      neovim-nightly-overlay,
      nix-homebrew,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      home-manager,
      ...
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          # $ nix-env -qaP | grep wget
          environment.systemPackages = import ./syspacks.nix stable pkgs;

          users.users.futar.home = "/Users/futar";

          fonts.packages = [
            (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
          ];

          nixpkgs.config = {
            allowUnfree = true;
            allowUnsupportedSystem = true;
            allowBroken = true;
          };

          # $PATH
          environment.systemPath = [
            "$HOME/.local/bin"
            "/opt/homebrew/bin"
          ];

          environment.variables = {
            XDG_DATA_HOME = "$HOME/.local/share";
            XDG_CONFIG_HOME = "$HOME/.config";
            XDG_STATE_HOME = "$HOME/.local/state";
            XDG_CACHE_HOME = "$HOME/.cache";
            EDITOR = "nvim";
            DEITY = "tpope";
            HOMEBREW_NO_ANALYTICS = "1";
          };

          environment.shellAliases = {
            e = "$EDITOR";
            q = "exit";
            ":q" = "exit";
            la = "ls -A";
            z = "j";
          };

          # environment.extraInit = ''
          #   yabai --start-service
          #   skhd --start-service
          # '';

          # environment.extraSetup = ''
          #   yabai --start-service
          #   skhd --start-service
          # '';

          # see /etc/zshrc
          programs.zsh = {
            enable = true;
            enableFzfCompletion = true;
            enableSyntaxHighlighting = true;
            promptInit = ''
              PROMPT="%B%F{green}%1~%f%b %# "
            '';

            # must I source these manually?
            loginShellInit = ''
              mkcd () { mkdir -p "$1" || return; cd "$1" }
              'touch!' () { mkdir -p "$(dirname "$1")" || return; touch "$1" }
              source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
              source ${pkgs.autojump}/share/autojump/autojump.zsh
              autoload -U +X bashcompinit && bashcompinit
              autoload -U +X compinit && compinit
              source <(mu --bash-completion-script `which mu`)
            '';
          };

          services.nix-daemon.enable = true;

          nix.settings = {
            experimental-features = [
              "nix-command"
              "flakes"
              "recursive-nix"
            ];
            use-xdg-base-directories = true;
          };

          system = import ./system.nix self;

          nixpkgs.hostPlatform = "aarch64-darwin";
          security.pam.enableSudoTouchIdAuth = true;
          time.timeZone = "Europe/London";

          homebrew = import ./homebrew.nix;
        };
    in
    {
      darwinConfigurations."Carmans-MacBook-Air" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "futar";
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = homebrew-bundle;
              };
              mutableTaps = false;
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.futar = import ./home.nix neovim-nightly-overlay;
            home-manager.backupFileExtension = "bak";
          }
          configuration
        ];
      };
      darwinPackages = self.darwinConfigurations."Carmans-MacBook-Air".pkgs;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
    };
}
