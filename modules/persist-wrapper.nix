{ config, lib, ... }:
let
  cfg = config.persist;
  listOfAny = lib.types.listOf lib.types.anything;
in {
  options.persist = {
    directories = lib.mkOption {
      default = [ ];
      description = "System-wide directories to persist.";
      type = listOfAny;
    };

    files = lib.mkOption {
      default = [ ];
      description = "System-wide files to persist.";
      type = listOfAny;
    };

    users = lib.mkOption {
      default = { };
      description = "Per-user directories and files to persist.";
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          directories = lib.mkOption {
            default = [ ];
            type = listOfAny;
          };
          files = lib.mkOption {
            default = [ ];
            type = listOfAny;
          };
        };
      });
    };
  };

  config = lib.mkIf config.preservation.enable {
    preservation.preserveAt."/persist" = {
      directories = cfg.directories;
      files = cfg.files;
      users = lib.mapAttrs (_: value: {
        directories = value.directories;
        files = value.files;
      }) cfg.users;
    };
  };
}
