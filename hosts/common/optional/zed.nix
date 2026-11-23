{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ zed-editor nixd ];

  persist.users.david.directories = [
    # ".config/zed"
    ".local/share/zed"
  ];
}
