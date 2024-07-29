{ config, pkgs, lib, ... }:

{
   imports = [
      ./hardware-configuration.nix
      <nixos-hardware/lenovo/thinkpad/t480s>
    ];

  nix.settings.experimental-features = [
   "nix-command"
   "flakes"
  ];
  # devenv settings
  nix.settings.substituters = ["https://devenv.cachix.org"];
  nix.settings.trusted-users = ["root" "nixos"];
  nix.settings.extra-trusted-public-keys = ["devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="];
  nixpkgs.config.allowUnfree = true;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-a07517ba-7b5d-4746-88e1-7c5922490ac5".device = "/dev/disk/by-uuid/a07517ba-7b5d-4746-88e1-7c5922490ac5";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  #services.xserver.libinput.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Enable the Plasme Desktop Environment.
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nix = {
    isNormalUser = true;
    description = "nix";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "corefonts" ];

  fonts.fonts = with pkgs; [
    corefonts
  ];

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "nix";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Install firefox.
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; let
    unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {};
  in [
    nextcloud-client
    gnome.nautilus-python
    remmina
    chromedriver
    fish
    unstable.neovim # Neovim Nightly wird explizit aus dem unstable Channel bezogen
    python3Full
    git
    btop
    element-desktop
    kdePackages.kio
    whois
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
    gnome-extension-manager
    gnome.gnome-shell-extensions
    gnome.gnome-tweaks
    gnome.gnome-themes-extra
    gnomeExtensions.thinkpad-battery-threshold
    gnome-browser-connector
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    gnomeExtensions.search-light
    gnomeExtensions.space-bar
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.logo-menu
    gnomeExtensions.pop-shell
    gnomeExtensions.gsconnect
    neofetch
    docker
    gcc
    appimage-run
    home-manager
    onlyoffice-bin
    p7zip
    gnome.gnome-boxes
    unstable.lunarvim
    usbutils
    fprintd
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    libimobiledevice
    ifuse # optional, to mount using 'ifuse'
    vmware-workstation
    tor-browser
    kdePackages.kdeconnect-kde
    libsForQt5.polonium
    kde-rounded-corners
];  
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    lua-language-server
    rust-analyzer
    tailwindcss-language-server
    djlint
  ];
  # jellyfin
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver # previously vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      onevpl-intel-gpu
      intel-media-sdk # QSV up to 11th gen
    ];
  };
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user="nix";
  };
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };  
  # iPod connect

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  # vmware config
  virtualisation.vmware.guest.enable = true;
  virtualisation.vmware.host.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  # programs.kdeconnect = { enable = true; package = pkgs.gnomeExtensions.gsconnect; };
  programs.kdeconnect.enable = true; 
  services.touchegg.enable = true;
  services.mullvad-vpn.enable = true;
  users.users.nix.shell = pkgs.fish;
  programs.fish.enable = true;
  services.openssh.enable = true;
  virtualisation.docker.enable = true;
  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';
  networking.firewall.allowedTCPPorts = [ 80 443 1401 5000 ];
  networking.firewall.allowedUDPPorts = [ 53 1194 1195 1196 1197 1300 1301 1302 1303 1400 5000 ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:
  # Open ports in the firewall.
  # Or disable the firewall altogether.
  # networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
