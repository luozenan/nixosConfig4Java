{ config, pkgs, ... }:

{
# Install firefox.
  #programs.firefox.enable = true;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    plugins = {
      lualine.enable = true;
    };
   opts = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
    }; 
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      si = "sudo -i";
      update = "sudo nixos-rebuild switch";
    };

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
	"docker"
      ];
      theme = "";
    };
    interactiveShellInit = ''
      eval "$(starship init zsh)"
    '';
  };
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      directory = {
      style = "bold cyan";
      truncation_length = 3;
    };
    
    git_branch = {
      symbol = " ";
      style = "bold purple";
    };
    
    nix_shell = {
      symbol = " ";
      style = "bold blue";
    };
    
    username = {
      show_always = false;
    };
    };
  };
  users.extraUsers.luozenan = {
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    neovim   
    starship
    zip
    unzip
    git
    wget
    yazi
    google-chrome
    appimage-run
    fastfetch
    xwayland-satellite
    libnotify
    pciutils
    usbutils
    linux-firmware 
 ];
 
 nixpkgs.overlays = [
    (self: super: {
      google-chrome = super.google-chrome.overrideAttrs (oldAttrs: {
        # 保留原有的postInstall逻辑，只追加删除多余文件的操作（不替换）
        postInstall = (oldAttrs.postInstall or "") + ''
          # 只删除多余的com.google.Chrome.desktop，绝对保留google-chrome.desktop
          if [ -f "$out/share/applications/com.google.Chrome.desktop" ]; then
            rm -f "$out/share/applications/com.google.Chrome.desktop"
          fi
        '';
      });
    })
  ];

  # 启用 libvirt 服务，这是使用 virt-manager 的前提
  virtualisation.libvirtd = {
    enable = true;
   # 启用 virtiofsd 支持，这会自动处理 qemu 依赖
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
  
services.linyaps.enable = true;
 programs.nix-ld = {
  enable = true;
  # 把 wine 要的基础库加进来
  libraries = with pkgs; [
    glibc
    gtk3
    pango
    cairo
    atk
    gdk-pixbuf
    glib
    dbus
    freetype
    fontconfig
    libx11
    libxext
    libxrender
    libxfixes
    libxcomposite
    libxdamage
    libxrandr
    libxinerama
    libxcursor
    libxi
    libxtst
    libxmu
    libxpm
    alsa-lib
    pulseaudio
    mesa
    vulkan-loader
  ];
}; 
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
}

