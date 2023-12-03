# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{config, pkgs, lib, ... }:
{
 imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #<nixos-hardware/lenovo/thinkpad/t480s>
    ];
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
'';
  nixpkgs.config.permittedInsecurePackages = [
  "openssl-1.1.1w"
  "electron-19.1.9"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-2208032c-677d-42bd-a89e-043a68d9f446".device = "/dev/disk/by-uuid/2208032c-677d-42bd-a89e-043a68d9f446";
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
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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
  sound.enable = true;
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
      spicetify-cli
      spotify
      teamspeak5_client
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  nextcloud-client
  gnome.nautilus-python
  remmina
  fish
  etcher
  neovim
  python312
  git
  gnumake
  nodejs_20
  pfetch
  nerdfonts
  gcc9
  vim
  intel-media-driver
  auto-cpufreq
  touchegg
  xclip
  ocs-url
  libinput
  gnomeExtensions.x11-gestures
  gnome.pomodoro
  gnome3.gnome-tweaks
  gnome.gnome-shell-extensions
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
  gnomeExtensions.rounded-corners
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
  # List services that you want to enable:
  services.gnome.gnome-browser-connector.enable = true;
  services.touchegg.enable = true;
  services.mullvad-vpn.enable = true;
  users.users.nix.shell = pkgs.fish;
  programs.fish.enable = true;
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 443 1401 5000 ];
  networking.firewall.allowedUDPPorts = [ 53 1194 1195 1196 1197 1300 1301 1302 1303 1400 5000 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
