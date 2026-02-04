{ config, pkgs, lib, inputs, ... }: {


 
  services.desktopManager.gnome.enable = true;
  services.gnome.gnome-keyring.enable = true; # secret service
  services.gnome.core-apps.enable = false;
  services.gnome.localsearch.enable = false;
  services.gnome.tinysparql.enable = false;
  services.gnome.gnome-online-accounts.enable = true;
  programs.dconf.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    # 精简不想安装的包
    gnome-tour
  ];

  environment.systemPackages = with pkgs; [
    gnome-console
    gnome-text-editor
    nautilus
    gnome-tweaks
    seahorse
    gnome-online-accounts
    gnome-system-monitor
    gnome-disk-utility
    gnome-builder
  ] ++ (with gnomeExtensions; [
    kimpanel
    dash-to-dock
    clipboard-history
    extension-list
    docker
    hide-top-bar
    blur-my-shell
    app-menu-is-back
    forge
    gsconnect
    rdp-and-ssh-connect
    logo-menu
    toggle-proxy
    rounded-window-corners-reborn
    desktop-icons-ng-ding
    astra-monitor
    bing-wallpaper-changer
  ]);
  
  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";  
  };

}
