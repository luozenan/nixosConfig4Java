{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [ 
    steam-run
  ];

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraArgs = "-system-composer";
      extraPkgs = pkgs': with pkgs'; [
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib # Provides libstdc++.so.6
      libkrb5
      keyutils
    # Add other libraries as needed
  ];
    };
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;

    extraPackages = with pkgs; [
      javaPackages.compiler.temurin-bin.jre-8
    ];
  };
  

  programs.gamescope = {
    enable = true;
    args = [
      "--borderless"
      "--force-grab-cursor"
      "-W 2560"
      "-H 1600"
    ];
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        desiredgov = "performance";
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send '游戏模式已开启' && ${pkgs.mako}/bin/makoctl mode -a do-not-disturb";
        end = "${pkgs.mako}/bin/makoctl mode -r do-not-disturb && ${pkgs.libnotify}/bin/notify-send '游戏模式已关闭'";
      };
    };
  };

  users.users.luozenan.extraGroups = [ "gamemode" ];

  hardware.steam-hardware.enable = true;

}

