{ pkgs, ...}:

{
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun"; # modi = plural of mode? drun = programs from .desktops
      show-icons = true;
    };
  };

  programs.waybar = {
    enable = true;
    settings = [
      {
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [];
        modules-right = [ "pulseaudio" "network" "battery" "clock" "tray" ];
        modules = {
          "clock" = {
            format = "{:%F %I:%M:%S %p}";
            interval = 1;
          };
        };
      }
    ];
  };

  services.gammastep = {
    enable = true;
    # Amherst, MA
    latitude = "42.38";
    longitude = "-72.52";
  };
}
