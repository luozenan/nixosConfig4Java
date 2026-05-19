{ config, pkgs, lib, ... }: {
# 设置系统的中文环境
  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
   };

   supportedLocales = [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
  };

  # 输入法配置（Fcitx5）
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
    fcitx5-rime
    rime-data
    fcitx5-gtk
    libsForQt5.fcitx5-qt
    kdePackages.fcitx5-chinese-addons
    kdePackages.fcitx5-configtool
   ];
   fcitx5.waylandFrontend = true;
  };
environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "fcitx";
    INPUT_METHOD = "fcitx";
    XMODIFIERS = "@im=fcitx";
    CLUTTER_IM_MODULE = "xim";
    LANGUAGE = "zh_CN:zh";
};
#environment.etc = {
#  "fcitx".source = "${pkgs.fcitx5}"; 
#  "fcitx-gtk".source = "${pkgs.fcitx5-gtk}";
#  "fcitx-qt".source = "${pkgs.kdePackages.fcitx5-qt}";
#  "fcitx-with-addons".source = "${pkgs.kdePackages.fcitx5-with-addons}"; 
#};
systemd.tmpfiles.rules = [
  # 已有的 Qt5 + GTK3 fcitx5 插件
  "C /usr/lib/x86_64-linux-gnu/qt5/plugins/platforminputcontexts/libfcitx5platforminputcontextplugin.so 755 root root - ${pkgs.libsForQt5.fcitx5-qt}/lib/qt-5.15.18/plugins/platforminputcontexts/libfcitx5platforminputcontextplugin.so"
  "C /usr/lib/x86_64-linux-gnu/gtk-3.0/3.0.0/immodules/im-fcitx5.so 755 root root - ${pkgs.fcitx5-gtk}/lib/gtk-3.0/3.0.0/immodules/im-fcitx5.so"

  # 新增 - XIM 前端（Wine 中文输入核心）
  "C+ /usr/lib/x86_64-linux-gnu/fcitx5/libxim.so 755 root root - ${pkgs.kdePackages.fcitx5-with-addons}/lib/fcitx5/libxim.so"
  #"L+ /usr/lib/x86_64-linux-gnu/fcitx5/libxim.so - - - - ${pkgs.fcitx5}/lib/fcitx5/libxim.so"
  "C /usr/lib/x86_64-linux-gnu/fcitx5/libfcitx4frontend.so 755 root root - ${pkgs.kdePackages.fcitx5-with-addons}/lib/fcitx5/libfcitx4frontend.so"

  # 新增 - GTK3 XIM 模块
  "C /usr/lib/x86_64-linux-gnu/gtk-3.0/3.0.0/immodules/im-xim.so 755 root root - ${pkgs.gtk3}/lib/gtk-3.0/3.0.0/immodules/im-xim.so"
];
system.activationScripts.deepinWineLocale = {
  deps = [];
  text = let
    script = pkgs.replaceVars ../scripts/setup-deepin-locale.sh {
      gzip = pkgs.gzip;
    };
  in ''
    ${pkgs.bash}/bin/bash ${script}
  '';
};
environment.variables = {
  QT_QPA_PLATFORM = "xcb";
  QT_FONT_DPI = "96";
  QT_SCALE_FACTOR = "1";
  QT_SELECTION_BACKEND = "primary";
  # 设置QT默认中文字体
  QT_DEFAULT_FONT = "Noto Sans CJK SC";
};
  # 中文字体优化
  fonts = {
  packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans    # 思源黑体 (无衬线)
    noto-fonts-cjk-serif   # 思源宋体 (衬线)
    nerd-fonts.jetbrains-mono
    ];
  fontconfig = {
    useEmbeddedBitmaps = true;
    defaultFonts = {
      sansSerif = [ "Noto Sans CJK SC" ];
      serif = [ "Noto Serif CJK SC" ];
     };
   };
 };
}
