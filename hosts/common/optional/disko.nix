{
  fileSystems."/nix".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;

  disko.devices.nodev = {
    "/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=25%"
        "mode=0755"
      ];
    };
  };

  disko.devices.disk.main = {
    device = "/dev/disk/by-id/nvme-CT2000P3PSSD8_25074E4E495B";
    type = "disk";

    content.type = "gpt";

    content.partitions.esp = {
      label = "boot";
      name = "ESP";
      size = "1G";
      type = "EF00";

      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/boot";
        mountOptions = [ "umask=0077" ];
      };
    };

    content.partitions.luks = {
      label = "luks";
      size = "100%";

      content = {
        name = "crypted";
        type = "luks";

        content = {
          type = "btrfs";
          extraArgs = [ "-L" "nixos" "-f" ];

          subvolumes = {
            "@nix" = {
              mountpoint = "/nix";
              mountOptions = [ "compress=zstd" "noatime" ];
            };
            "@persist" = {
              mountpoint = "/persist";
              mountOptions = [ "compress=zstd" "noatime" ];
            };
            "@swap" = {
              mountpoint = "/swap";
              mountOptions = [ "compress=no" "nodatacow" "noatime" ];
              swap.swapfile.size = "32G";
            };
          };
        };
      };
    };
  };
}
