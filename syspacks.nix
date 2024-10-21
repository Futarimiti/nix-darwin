_pkgs: unstable: with unstable; [
  haskellPackages.hasktags
  haskellPackages.haskdogs
  haskellPackages.cabal2nix
  haskell.compiler.ghcHEAD
  mas
  mutt
  aerc
  fd
  git
  tree-sitter
  curl
  tmux
  autojump # config later
  ripgrep
  darwin.trash
  irssi
  yt-dlp
  tree
  tikzit
  zsh-autosuggestions
  # qutebrowser # build fail

  skhd
  yabai

  # dev kits & envs
  ffmpeg_7
  nodejs_22
  idris
  idris2
  jdk22
  python313
  stack
  dhall
  # cabal-install
  texliveFull

  # tools
  # neovide
  yamlfmt
  stylish-haskell
  stylua
  astyle
  nixfmt-rfc-style

  _2048-in-terminal

  # for others to run smoothly
  gsettings-desktop-schemas # for gitg (still no work)
]
