{config, pkgs, lib, ... }:
{
 imports = [
      ./hardware-configuration.nix
      <nixos-hardware/lenovo/thinkpad/t480s>
      ./nix-alien.nix
    ];
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
'';
  nixpkgs.config.permittedInsecurePackages = [
  "openssl-1.1.1w"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-2208032c-677d-42bd-a89e-043a68d9f446".device = "/dev/disk/by-uuid/2208032c-677d-42bd-a89e-043a68d9f446";
  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  console.keyMap = "de";

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.libinput.enable = true;

  # Benutzerkonfiguration
  users.users.nix = {
    isNormalUser = true;
    description = "nix";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      session-desktop
      kitty
      telegram-desktop
      discord
      flameshot
      neovim
      mullvad-vpn
      github-desktop
      ocs-url
      mullvad-browser
      krita
      spicetify-cli
      spotify
      lutris
      sabnzbd
      teamspeak_client
      onlyoffice-bin
    ];
  };

  # Realtime-Gruppenkonfiguration
 

  # Rest der Konfiguration
  # Rest der Konfiguration
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: with pkgs; {
      pidgin-with-plugins = pkgs.pidgin.override {
        plugins = [ pidgin-otr ];
      };
    };
  };
  environment.systemPackages = with pkgs; [
    nextcloud-client
    gnome.nautilus-python
    remmina
    fish
    neovim
    python312
    git
    gnumake
    tdrop
    nodejs_20
    nerdfonts
    vim
    intel-media-driver
    auto-cpufreq
    touchegg
    xclip
    ocs-url
    fira-code
    libinput
    gnomeExtensions.x11-gestures
    exodus
    pidgin-with-plugins  # Ersetzen Sie 'pidgin' und 'pidginPackages.pidgin-otr' hiermit
    gnome.pomodoro
    gnome3.gnome-tweaks
    gnome.gnome-shell-extensions
    gnome.gnome-themes-extra 
    catppuccin-gtk
    gnomeExtensions.thinkpad-battery-threshold
    gnome-browser-connector
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    gnomeExtensions.search-light
    gnomeExtensions.space-bar
    gnomeExtensions.top-bar-organizer
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.logo-menu
    neofetch
    gcc
    appimage-run
    
  ];


  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.gnome.gnome-browser-connector.enable = true;
  services.touchegg.enable = true;
  services.mullvad-vpn.enable = true;
  users.users.nix.shell = pkgs.fish;
  programs.fish.enable = true;
  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 443 1401 5000 ];
  networking.firewall.allowedUDPPorts = [ 53 1194 1195 1196 1197 1300 1301 1302 1303 1400 5000 ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
