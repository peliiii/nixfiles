{ pkgs, ... }: {
  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      keyboard.layout = "de";
    };
  };
  programs.umbriel.enable = true;
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
    systemd.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [ bibata-cursors ];
}
