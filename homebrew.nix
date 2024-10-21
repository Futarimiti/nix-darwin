{
  enable = true;
  onActivation = {
    cleanup = "zap";
    upgrade = true;
    autoUpdate = true;
  };

  taps = [ ];
  brews = [
    # no work with nix https://discourse.nixos.org/t/having-issues-with-swift-5-8-build/46871
    "mpv"
    # the one provided by nixpkgs does not support darwin, still no work?
    # "gitg"
    "manim"
  ];
  casks = [
    "qlmarkdown"
    "qq"
    "wechat"
    "obs"
    "iterm2"
    "neovide"
    "keycastr"
  ];
  masApps = {
    Vimlike = 1584519802;
    Userscripts = 1463298887;
    "Microsoft Word" = 462054704;
    Pages = 409201541;
    # Translatium = -2048184103;  # mas int32 overflow bug
  };
  global = {
    brewfile = true;
  };
}
