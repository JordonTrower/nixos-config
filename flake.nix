{
  description = "NixOS tutorial first flake help";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
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

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llama-cpp = {
      url = "github:ggml-org/llama.cpp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      home-manager,
      caelestia-shell,
      caelestia-cli,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      # Get list of server directories
      serverDirs = lib.attrNames (builtins.readDir ./server-hosts);
      # Filter to only include directories that start with "jospNix"
      serverHosts = lib.filter (name: lib.hasPrefix "jospNix" name) serverDirs;
      # Create nixosConfigurations for each server
      serverConfigs = lib.genAttrs serverHosts (
        name:
        lib.nixosSystem {
          inherit system;
          modules = [
            { networking.hostName = name; }
            (./server-hosts + "/${name}/configuration.nix")
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.josp = import ./server-hosts/server-home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };

              };

            }
          ];
          specialArgs = { inherit inputs; };
        }
      );
    in
    {
      nixosConfigurations = lib.recursiveUpdate serverConfigs {
        jospNixLaptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { networking.hostName = "jospNixLaptop"; }
            ./configuration.nix
            ./hardware-configs/laptop.nix
            ./nvidia-config.nix
            ./caelestia.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.josp = import ./home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };

              };

            }
          ];
          specialArgs = {
            inherit inputs;
            inherit caelestia-cli;
            inherit caelestia-shell;
          };
        };

        jospNixDesktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { networking.hostName = "jospNixDesktop"; }
            ./configuration.nix
            ./hardware-configs/desktop.nix
            ./noctalia.nix
            ./smb.nix
            ./nfs.nix
            ./llama-cpp.nix
            ./packages/amd.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.josp = import ./home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };

              };

            }
          ];

          specialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
