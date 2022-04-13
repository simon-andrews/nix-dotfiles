{ config, lib, pkgs, ... }:

let
  python-with-global-packages = pkgs.python3.withPackages(ps: with ps; [
    # Useful libraries to have on-hand
    beautifulsoup4
    bpython
    django_3 # django_4 WIP: https://github.com/NixOS/nixpkgs/pull/153530
    faker
    matplotlib
    networkx
    numpy
    opencv4
    pandas
    pytorch
    requests
    scikit-learn
    scipy
    seaborn
    torchvision
    tqdm

    # Development tools
    black
    flake8
    isort
    mypy

    # Jupyter and extensions
    ipywidgets
    jupyterlab

    # Self-packaged libraries
    (callPackage ./self_packaged/django-crispy-forms.nix {})
    (callPackage ./self_packaged/crispy-bootstrap5.nix {})
  ]);
  # mach-nix = (pkgs.callPackage (fetchTarball https://github.com/DavHau/mach-nix/tarball/3.4.0) {}).mach-nix;

in

{
  imports =
  [
    ./chromium.nix
    ./desktop.nix
    ./systemd.nix
    ./terminal-environment.nix
    ./vscodium.nix
  ];

  home.username = "simon";
  home.homeDirectory = "/home/simon";

  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "authy"
      "minecraft-launcher"
      "slack"
      "spotify"
      "spotify-unwrapped"
      "teams"
      "vscode-extension-ms-vscode-cpptools"
      "zoom"
    ];
    permittedInsecurePackages = [
      "electron-9.4.4" # for Authy
    ];
  };

  fonts.fontconfig.enable = true;

#  services.flameshot = {
#    enable = true;
#    settings = {
#      # https://github.com/flameshot-org/flameshot/blob/master/flameshot.example.ini
#      General = {
#        ignoreUpdateToVersion = 999;
#        disabledTrayIcon = true;
#      };
#    };
#  };

  # Packages that should be installed to the user profile
  home.packages = [

    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    pkgs.act
    pkgs.adoptopenjdk-bin
    pkgs.docker-compose
    pkgs.evince
    pkgs.file
    pkgs.filezilla
    pkgs.ffmpeg
    pkgs.gnome.cheese
    pkgs.heroku
    pkgs.pinentry-curses
    pkgs.gnumake
    pkgs.gimp
    pkgs.minecraft
    pkgs.nodejs
    pkgs.qalculate-gtk
    pkgs.spotify
    pkgs.vlc
    pkgs.wget
    pkgs.xorg.xhost # for wayland/docker
    pkgs.z3

    # Administration
    pkgs.font-manager
    pkgs.gparted
    pkgs.htop
    pkgs.pavucontrol
    pkgs.polkit_gnome

    # Authentication
    pkgs.authy
    pkgs.bitwarden

    # C/C++ development
    pkgs.clang
    pkgs.cmake
    pkgs.lldb
    pkgs.llvmPackages.bintools-unwrapped
    pkgs.mold

    # Communication
    pkgs.slack
    pkgs.teams
    pkgs.thunderbird
    pkgs.torbrowser
    pkgs.zoom-us

    # Python
    (lib.hiPrio python-with-global-packages) # use hiPrio because lldb ships with its own version of six that conflicts with this one

    # Sway
    pkgs.font-awesome
    pkgs.mako
    pkgs.swayidle
    pkgs.swaylock
    pkgs.wdisplays
    pkgs.wl-clipboard

    # Rust
    pkgs.cargo
    pkgs.rustc
    pkgs.rustfmt

    # Terminal tools
    pkgs.jq
    pkgs.neofetch
    pkgs.ripgrep
    pkgs.tmux

    # Thunar
    pkgs.xfce.tumbler
    pkgs.xfce.thunar
    pkgs.xfce.thunar-archive-plugin
    pkgs.xfce.thunar-volman

    # (Un)archiving
    pkgs.unzip
    pkgs.zip
  ];

  programs.git = {
    enable = true;
    userName = "Simon Andrews";
    userEmail = "public@simonandre.ws";
  };

  programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
    font = {
      name = "Fira Code Regular Nerd Font Complete Mono";
    };
    settings = {
      bold_font = "Fira Code Bold Nerd Font Complete Mono";
      font_size = 11;
      disable_ligatures = "always";
      cursor_blink_interval = 0;
    };
  };

  home.file = {
    "sway" = {
      source = ./sway;
      target = ".config/sway";
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
