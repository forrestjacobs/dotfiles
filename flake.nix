{
  outputs = { ... }: {
    homeModules.default = ({ lib, pkgs, config, ... }: {
      home.stateVersion = "23.11";

      home.packages = [
        pkgs.bat
        pkgs.eza
        pkgs.fish
        pkgs.helix
        pkgs.patchutils
        pkgs.zoxide
      ];

      programs.git = {
        enable = true;
        userName = "Forrest Jacobs";
        userEmail = lib.mkDefault "forrestjacobs@gmail.com";
        extraConfig = {
          pull.ff = "only";
          init.defaultBranch = "main";
        };
      };

      home.file."${config.xdg.configHome}" = {
        source = ./config;
        recursive = true;
      };
    });
  };
}
