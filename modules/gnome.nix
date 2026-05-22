{ config, pkgs, lib, inputs, ... }: 
let
  hanabi-extension = pkgs.callPackage ../customConfig/hanabi.nix {};
in
{


 
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
    hanabi-extension
    clapper
    gnome-console
    xdg-desktop-portal
    xdg-desktop-portal-gnome
    gnome-text-editor
    nautilus
    gnome-tweaks
    seahorse
    gnome-online-accounts
    gnome-system-monitor
    gnome-disk-utility
    gnome-builder
    # gnome美化
    oreo-cursors-plus
    bibata-cursors
    reversal-icon-theme
    flat-remix-gnome
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
    #rdp-and-ssh-connect
    logo-menu
   # toggle-proxy
    rounded-window-corners-reborn
    desktop-icons-ng-ding
    astra-monitor
    bing-wallpaper-changer
    user-themes
    paperwm
    just-perfection
  ]);
  
  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";  
  };

}
