{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../common/global
    ../common/optional/desktop.nix
    ../common/optional/disko.nix
    ../common/optional/firefox.nix
    ../common/optional/preservation.nix
  ];

  boot.loader.limine.enable = true;
  boot.loader.limine.maxGenerations = 10;
  boot.loader.limine.secureBoot = {
    enable = true;
    autoEnrollKeys.enable = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."crypted" = {
    device = "/dev/disk/by-partlabel/luks";
    allowDiscards = true;
    crypttabExtraOpts = [ "tpm2-device=auto" ];
  };

  services.fprintd.enable = true;
  security.pam.services.sudo-rs.fprintAuth = true;
  security.pam.services.login.fprintAuth = false;
  security.sudo-rs.enable = true;

  systemd.user.services.tuckr-restore = {
    description = "Restore dotfiles symlinks with Tuckr";
    wantedBy = [ "default.target" ];
    before = [ "graphical-session-pre.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.tuckr}/bin/tuckr add *";
    };
  };

  networking.hostName = "fw13";

  users.users.david = {
    isNormalUser = true;
    description = "david";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;

    hashedPasswordFile = "/persist/passwd";
  };

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    git
    ghostty
    tuckr
  ];

  system.stateVersion = "26.11";
}
