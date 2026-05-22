{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    #winboat
   # wine-wayland
    #winetricks
    #安装企业微信前  在DLL组件里下载DXVK2.5 容器选择这个版本
    #安装企业微信后 需要安装依赖项 webview2 vcredist2022 vccrdist2019 cjkfonts riched20 d3dx9 winhttp dotnet48 设置环境变量 GTK_IM_MODULE=fcitx INPUT_METHOD=fcitx QT_IM_MODULE=fcitx XMODIFIERS=@im=fcitx
    #(bottles.override { removeWarningPopup = true; })
    #docker-compose
 ];

# In /etc/nixos/configuration.nix
#virtualisation.docker.enable = true;

# Optional: Add your user to the "docker" group to run docker without sudo
#users.users.luozenan.extraGroups = [ "docker" ];
 

}

