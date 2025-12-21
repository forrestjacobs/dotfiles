{
  outputs = { ... }: {
    homeModules.default = ({ lib, pkgs, config, ... }:
    
    let
      dotfilesBin = (pkgs.stdenv.mkDerivation {
        name = "dotfiles-bin";
        src = ./home/.local/bin;
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
        pkgs.fd
        pkgs.fish
        pkgs.fzf
        pkgs.helix
        pkgs.htop
        pkgs.lazygit
        pkgs.mise
        pkgs.patchutils
        pkgs.ripgrep
        pkgs.starship
        pkgs.wget
        pkgs.zoxide
      ];

      home.file.".local/bin/dot_shell".source = "${dotfilesBin}/bin/dot_shell";

      home.file."${config.xdg.configHome}" = {
        source = ./home/.config;
        recursive = true;
      };

      programs.git.settings = {
        init.defaultBranch = "main";
        pull.ff = "only";
      };
    });
  };
}
