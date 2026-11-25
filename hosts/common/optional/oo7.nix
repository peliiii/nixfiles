{
  services.oo7.enable = true;

  security.pam.services.login.oo7.enable = true;

  persist.users.david.directories = [
    { directory = ".local/share/keyrings"; mode = "0700"; }
  ];
}
