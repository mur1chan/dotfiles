{ config, pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);

    };
  };
  home.username = "nix";
  home.homeDirectory = "/home/nix";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
              nixpkgs.config.permittedInsecurePackages = [
                "python3.11-youtube-dl-2021.12.17"
              ];
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.vivaldi
    pkgs.corefonts
    pkgs.gradience
    pkgs.teams-for-linux
    pkgs.colloid-icon-theme
    pkgs.firefox
    pkgs.kitty
    pkgs.distrobox
    pkgs.vesktop
    pkgs.github-desktop
    pkgs.ocs-url
    pkgs.keepassxc
    pkgs.spotify
    pkgs.sabnzbd
    pkgs.ripgrep
    pkgs.bottom
    pkgs.unzip
    pkgs.qemu
    pkgs.quickemu
    pkgs.cryptomator
    pkgs.ripgrep
    pkgs.wget
    pkgs.python311Packages.pip
    pkgs.tailwindcss-language-server
    pkgs.nil
    pkgs.djlint
    pkgs.ast-grep
    pkgs.tldr
    pkgs.vscode
    pkgs.mpv-unwrapped
    pkgs.yazi
    pkgs.rage
    pkgs.pwgen
    pkgs.uv
    pkgs.zoxide
    pkgs.marksman
    pkgs.obs-studio
    pkgs.tracker
    pkgs.gst_all_1.gstreamer
    pkgs.pkg-config
    pkgs.openssl
    pkgs.gcc
    pkgs.zlib
    pkgs.lazygit
    pkgs.gh
    pkgs.languagetool
    pkgs.fastfetch
    pkgs.nixpacks
    pkgs.ffmpeg
    pkgs.lollypop
    pkgs.picard
    pkgs.soundconverter
    pkgs.libarchive
    pkgs.gnupg
    pkgs.krita
    pkgs.tailwindcss
    pkgs.fzf
    pkgs.celluloid
    pkgs.libgpod
    pkgs.rhythmbox
    pkgs.localsend
    pkgs.filezilla
    pkgs.jellyfin-media-player
    pkgs.qbittorrent
    pkgs.google-chrome
    pkgs.betterbird
    pkgs.kdenlive
    pkgs.mullvad-browser
    pkgs.zip
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
  home.sessionVariables = {
    XDG_DATA_DIRS = "${pkgs.kitty}/share:${config.home.homeDirectory}/.local/share:${config.xdg.dataHome}";
  };
  home.file = {
    ".local/share/applications/kitty.desktop".text = ''
      [Desktop Entry]
      Version=1.0
      Name=Kitty
      GenericName=Terminal Emulator
      Comment=A fast, featureful, GPU based terminal emulator
      Exec=kitty
      Icon=/home/nix/.customicons/kitty.icns
      Terminal=false
      Type=Application
      Categories=Utility;TerminalEmulator;
    '';
  };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nix/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
#    GTK_THEME = "WhiteSur-Light";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.yazi.enableFishIntegration = true;
  nixpkgs.config = {
    packageOverrides = pkgs: with pkgs; {
     #  pidgin-with-plugins = pidgin.override {
     #    plugins = [ pidgin-otr ];
     # };
#      whitesur-gtk-theme = whitesur-gtk-theme.override {
#      	altVariants = ["all"];
# colorVariants = ["Light"];
# opacityVariants = ["solid"];
# themeVariants = ["pink"];
# nautilusStyle = "glassy";
#      };
      catppuccin-kde = catppuccin-kde.override {
       accents = [ "pink" ];
       size = "standard";
       tweaks = [ "rimless" ];
       variant = "latte";
      };
   };
 };
}
