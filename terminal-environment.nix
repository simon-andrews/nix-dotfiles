{ pkgs, ...}:

{
  programs.bash = {
    enable = true;
    sessionVariables = {
      EDITOR = "nvim";
      RUST_BACKTRACE = 1;
    };
    shellAliases = {
      cat = "bat --paging=never";
      code = "codium";
      grep = "rg";
      ld = "mold";
      ls = "lsd";
      python = "bpython";
      ssh = "kitty +kitten ssh";
      tree = "lsd --tree";
    };
    bashrcExtra = ''
      # Don't run in pure nix-shell environments
      if [ "$IN_NIX_SHELL" == "pure" ]; then
        export TERM=xterm-256color
        return 0
      fi
    '';
  };

  programs.bat.enable = true;

  programs.lsd.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      i3config-vim
      typescript-vim
      vim-gitgutter
      vim-nix
      vim-numbertoggle
    ];
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
      format = "$nix_shell$git_branch$directory$character";
      character = {
        success_symbol = "[\\$](bold green)";
        error_symbol = "[\\$](bold red)";
      };
      directory = {
        format = "[$path]($style) ";
        truncation_length = 1;
        fish_style_pwd_dir_length = 1;
      };
      git_branch = {
        format = "[\\($symbol$branch\\)]($style) ";
      };
      nix_shell = {
        format = "[\\($symbol$name\\)]($style) ";
        symbol = "❄️ ";
      };
    };
  };
}
