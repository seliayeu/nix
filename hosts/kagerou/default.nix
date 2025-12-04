{ config, pkgs, pkgs-stable, inputs, ... }:
{
  imports = [
    ./greetd.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "nvme_core.default_ps_max_latency_us=0" ];

  networking.hostName = "kagerou";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Edmonton";

  i18n.defaultLocale = "en_CA.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.dotuncle = {
    isNormalUser = true;
    description = "Dan";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.systemPackages = [
    pkgs.wget
    pkgs.git
    pkgs.vim
    pkgs.wl-clipboard
    pkgs.mako
    pkgs.tailscale
    pkgs.deluge
    pkgs.gnused
    pkgs.direnv
    pkgs.nix-direnv
    pkgs.nvme-cli
    pkgs.smartmontools
    pkgs.qmk
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  services.udisks2.enable = true;

  environment.variables.editor = "vim";
  environment.sessionVariables = {
    ADW_DISABLE_PORTAL = "1";
  };

  programs.sway.enable = true;
  services.tailscale.enable = true;
  # security.polkit.enable = true;

  programs.zsh.enable = true;
  services.deluge = {
    enable = true;
  };
  users.defaultUserShell = pkgs.zsh;

  services.openssh.enable = true;

  system.stateVersion = "25.05";
}
