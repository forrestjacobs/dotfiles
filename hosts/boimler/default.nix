{ ... }:
{

  imports = [
    ../../nixos

    ./docker.nix
    ./hardware-configuration.nix
    ./media.nix
    ./plasma.nix
  ];

  # from local config

  impermanence.enable = true;

  # from global config

  environment.etc.machine-id.source = "/etc/nixos/local/machine-id";

  networking.hostName = "boimler";

  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = "/etc/nixos/local/cloudflare-api-token";
    ipv4 = true;
    ipv6 = false;
    domains = [ "boimler.t19.co" ];
  };

  services.cloudflared = {
    enable = true;
    tunnels."2a9a5063-1732-45fd-a1f7-2520f9120c25" = {
      credentialsFile = "/etc/nixos/local/cloudflared/tunnel.json";
      default = "http_status:404";
    };
  };

  services.openssh.enable = true;

  services.syncthing.enable = true;

  users.users.forrest.passwordFile = "/etc/nixos/local/forrest-password";

}

