{
  outputs = { ... }: {
    homeModules.default = ({ lib, pkgs, config, ... }: {
      home.stateVersion = "23.11";

      home.packages = [
        pkgs.bat
        pkgs.eza
        pkgs.fish
        pkgs.git
        pkgs.helix
        pkgs.patchutils
        pkgs.zoxide
      ];

      home.file."${config.xdg.configHome}" = {
        source = ./config;
        recursive = true;
      };
    });
  };
}
