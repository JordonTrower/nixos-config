{
  description = "NixOS tutorial first flake help";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      caelestia-shell,
      caelestia-cli,
      ...
    }:
    {
      nixosConfigurations.jospNixLaptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix

          #				{
          #					wayland.windowManager.hyprland = {
          #						enable = true;
          #						package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          #						portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
          #					};
          #				}
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.josp = import ./home.nix;
              backupFileExtension = "backup";
            };

          }
        ];
        specialArgs = {
          inherit caelestia-shell;
          inherit caelestia-cli;
            
        };
      };
    };
}
