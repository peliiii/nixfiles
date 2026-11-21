{
  boot.tmp.cleanOnBoot = true;

  preservation.enable = true;
  preservation.preserveAt."/persist" = {
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/sbctl"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      "/etc/NetworkManager/system-connections"
      { directory = "/tmp"; mode = "1777"; }
    ];

    files = [ ];

    users.david = {
      directories = [
        ".config/dotfiles"
        ".local/state/noctalia"
        ".local/state/wireplumber"
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Projects"
        { directory = ".local/share/keyrings"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
      ];

      files = [ ];
    };
  };
}
