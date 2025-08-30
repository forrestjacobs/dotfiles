{
  outputs = { ... }: {
    homeModules.default = ({ lib, pkgs, config, ... }:
    
    let
      dotfilesBin = (pkgs.stdenv.mkDerivation {
        name = "dotfiles-bin";
        src = ./bin;
        installPhase = ''
          mkdir -p $out/bin
          cp * $out/bin
        '';
      });

    in
    {
      home.stateVersion = "23.11";

      home.packages = [
        dotfilesBin
        pkgs.bat
        pkgs.eza
        pkgs.fish
        pkgs.fzf
        pkgs.helix
        pkgs.patchutils
        pkgs.zoxide
      ];

      home.file.".local/bin/init_shell".source = "${dotfilesBin}/bin/init_shell";

      home.file."${config.xdg.configHome}" = {
        source = ./config;
        recursive = true;
      };

      programs.git = {
        enable = true;
        userName = "Forrest Jacobs";
        userEmail = "forrestjacobs@gmail.com";
        extraConfig = {
          init.defaultBranch = "main";
          pull.ff = "only";
        };
      };
    });
  };
}
