self: {
  activationScripts = {
    no-start-chime.text = "sudo nvram StartupMute=%01";
  };
  configurationRevision = self.rev or self.dirtyRev or null;
  stateVersion = 4;
  defaults = {
    NSGlobalDomain.AppleFontSmoothing = 2;
    dock = {
      autohide = true;
      autohide-delay = 1000.0;
      dashboard-in-overlay = true;
      mineffect = "scale";
      minimize-to-application = true;
      mru-spaces = false;
      orientation = "left";
      persistent-apps = [ ];
      persistent-others = [ ];
      show-recents = false;
      showhidden = true;
      wvous-bl-corner = 14;
      wvous-br-corner = 4;
    };
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXEnableExtensionChangeWarning = false;
      ShowPathbar = true;
    };
    screencapture = {
      disable-shadow = true;
      location = "~/Desktop";
    };
    magicmouse.MouseButtonMode = "TwoButton";
    menuExtraClock = {
      Show24Hour = false;
      ShowAMPM = true;
    };
    trackpad = {
      ActuationStrength = 0;
      Clicking = true;
      Dragging = false;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = true;
    };
  };
}
