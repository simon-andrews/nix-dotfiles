{ pkgs, ... }:

{
  # https://github.com/nix-community/home-manager/issues/2064#issuecomment-887300055
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  systemd.user.services.clear-downloads = {
    Unit = {
      Description = "Remove everything in ~/Downloads on reboot";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "/bin/sh -c '${pkgs.coreutils}/bin/rm -rfv /home/simon/Downloads/*'"; # https://askubuntu.com/a/1162995
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.services.home-manager-expire-old-generations = {
    Unit = {
      Description = "Expire old home-manager generations";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.home-manager}/bin/home-manager expire-generations '-5 days'";
    };
    Install = {
      WantedBy = [ "home-manager-expire-old-generations.timer" ];
    };
  };

  systemd.user.timers.home-manager-expire-old-generations = {
    Unit = {
      Description = "Expire old home-manager generations daily";
    };
    Timer = {
      OnCalendar = "*-*-* 23:55:00";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
