{ config, pkgs, lib, inputs, ... }: {

  programs.xwayland.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;
  security.polkit.enable = true; # polkit

  environment.systemPackages = with pkgs; [
    xorg.xrandr
    desktop-file-utils
  ];
  
  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";  
  };

}
