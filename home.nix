{ config, pkgs, lib, ... }:

{
  # ========== 你原有所有配置（完全保留） ==========
  programs.ssh = {
    extraConfig = ''
    IdentityFile /home/luozenan/.ssh/zenan.luo@cue.group
    IdentityFile /home/luozenan/.ssh/github
    '';
  };

  programs.git = {
    enable = true;
    settings = {
       user.name = "zenan.luo";
       user.email = "zenan.luo@cue.group";
    };
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.file.".icons/default/index.theme".text = ''
    [Icon Theme]
    Name=Default
    Inherits=${config.home.pointerCursor.name}
  '';

  home.sessionVariables = {
    XCURSOR_PATH = "$HOME/.icons:${pkgs.bibata-cursors}/share/icons:$XCURSOR_PATH";
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel";
    #ANTHROPIC_API_KEY = "sk-ant-sid02-SsYGCCtmQ5qz7uqbx4jH8A-L7xCIEghX8iSw3cXoAcBF";
    STARSHIP_CONFIG = "${config.home.homeDirectory}/.config/starship.toml";
  };

  dconf.settings = {
    "org.gnome.desktop.interface" = {
      cursor-theme = config.home.pointerCursor.name;
      cursor-size = config.home.pointerCursor.size;
    };
  };

programs.vscode = {
  enable = true;
  profiles.default.extensions = with pkgs.vscode-extensions; [
    #anthropic.claude-code
  ];
}; 
}
