{ pkgs, ... }:
{
  programs.vscodium = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # Notebooks
        ms-toolsai.jupyter
        ms-toolsai.jupyter-renderers
        ms-python.python
        detachhead.basedpyright

        # Typst
        myriad-dreamin.tinymist

        # Nix
        jnoortheen.nix-ide
      ];

      userSettings = {
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontSize" = 14;
        "telemetry.telemetryLevel" = "off";

        # Nix language server + formatter
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.formatterPath" = "nixfmt";
      };
    };
  };

  # Tools the Nix extension uses
  home.packages = [
    pkgs.nixd
    pkgs.nixfmt
  ];
}
