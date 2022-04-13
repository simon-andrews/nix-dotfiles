{ pkgs, ... }:

let
  packagedExtensions = with pkgs.vscode-extensions; [
    arrterian.nix-env-selector
    bbenoist.nix
    editorconfig.editorconfig
    matklad.rust-analyzer
    ms-azuretools.vscode-docker
    ms-python.python
    ms-toolsai.jupyter
    ms-vscode.cpptools
  ];
  marketplaceExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscode-django";
      publisher = "batisteo";
      version = "1.10.0";
      sha256 = "bd3684dca846e62da319ce68df7bbbe91514158696e2ce26b87be9878f07790e";
    }
    {
      # I sometimes need to SSH into a computer with an ancient version of
      # glibc, which VS Code's normal SSH remote doesn't support.
      name = "vscode-sshfs";
      publisher = "Kelvin";
      version = "1.24.1";
      sha256 = "22dbb3c0ee94047986d2d81d3b1f37fca0c5a4ae2ca0d60002f4f97961287dad";
    }
  ];

in

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = packagedExtensions ++ marketplaceExtensions;
    userSettings = {
      "editor.fontFamily" = "'FiraCode Nerd Font', monospace";
      "editor.insertSpaces" = true;
      "editor.tabSize" = 2;
      "files.exclude" = {
        "**/.DS_Store" = true;
        "**/.git" = true;
        "**/.ipynb_checkpoints" = true;
        "**/*.swp" = true;
        "node_modules" = true;
      };
      "files.insertFinalNewline" = true;
      "update.mode" = "none";
      "workbench.startupEditor" = "none";

      # Third-party extensions
      "jupyter.askForKernelRestart" = false;
      "rust-analyzer.lens.enable" = false;
      "rust-analyzer.inlayHints.enable" = false;
      "sshfs.configs" = import ./sshfs-configs.nix;
    };
  };
}
