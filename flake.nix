{
  description = "NixOS flake-configuration with Noctalia";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };

  nixvim = {
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };
 
  apifox-github = {
    url = "github:luozenan/nixos-apifox";
    inputs.nixpkgs.follows = "nixpkgs";
  }; 
  electerm-github = {
    url = "github:luozenan/nixos-electerm";
    inputs.nixpkgs.follows = "nixpkgs";
  }; 
  finalshell-github = {
    url = "github:luozenan/nixos-finalshell";
    inputs.nixpkgs.follows = "nixpkgs";
  }; 

};
 
  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, ... }: 
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    configDir = ./modules;
    generatedModules = builtins.map (file: configDir + "/${file}") 
      (builtins.filter (file: nixpkgs.lib.hasSuffix ".nix" file) 
        (builtins.attrNames (builtins.readDir configDir)));
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { 
        inherit inputs;
	system = "x86_64-linux";
      };
      
      modules = [
          nixvim.nixosModules.nixvim
      	  home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs.flake-inputs = inputs;
            home-manager.users.luozenan.imports = [
              ./home.nix
            ];
            home-manager.users.luozenan.home.stateVersion = "25.11";
	  }
          ./configuration.nix
      ] ++ generatedModules; 
    };
  };
}
