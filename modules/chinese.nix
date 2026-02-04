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
    kdePackages.fcitx5-qt
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
