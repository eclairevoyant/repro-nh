{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    {
      nixosConfigurations.test = nixpkgs.lib.nixosSystem {
        modules = [
          (
            { modulesPath, ... }:
            {
              imports = [ "${modulesPath}/profiles/minimal.nix" ];

              boot.loader.grub.enable = false;
              fileSystems."/".device = "nodev";
              nixpkgs.hostPlatform = "x86_64-linux";
              system.stateVersion = "24.05";

              # custom config here
              programs.nh = {
                enable = true;
                flake = "/etc/nixos";
              };
            }
          )
        ];
      };
    };
}
