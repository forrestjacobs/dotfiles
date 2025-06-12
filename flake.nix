{
  outputs = { ... }: {
    homeModules.default = ({ lib, pkgs, config, ... }: {
      home.stateVersion = "23.11";

      home.packages = [
        (pkgs.stdenv.mkDerivation {
          name = "dotfiles-bin";
          src = ./bin;
          installPhase = ''
            mkdir -p $out/bin
            cp * $out/bin
          '';
        })
        pkgs.bat
        pkgs.eza
        pkgs.fish
        pkgs.helix
        pkgs.patchutils
        pkgs.zoxide
      ];

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
