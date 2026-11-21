{
  nix = {
    settings = {
      experimental-features = [ "flakes" "nix-command" ];
      trusted-users = [ "david" ];
      auto-optimise-store = true;
    };
  };
}
