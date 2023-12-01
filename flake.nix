{
  inputs.nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
  outputs = {
    self,
    nixpkgs-stable,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    packages.${system} = {
      execline = nixpkgs-stable.legacyPackages.${system}.buildEnv {
        name = "execline";
        paths = [];
        postBuild = ''
          mkdir -p $out/bin
          ln -s ${nixpkgs-stable.legacyPackages.${system}.execline}/bin/execlineb $out/bin/
          ln -s ${nixpkgs-stable.legacyPackages.${system}.execline}/bin/execline-cd $out/bin/
        '';
      };

      devbox-run = nixpkgs-stable.legacyPackages.${system}.buildEnv {
        name = "devbox-run";
        paths = [
          ./devbox-run
          self.packages.${system}.execline
          nixpkgs-stable.legacyPackages.${system}.devbox
        ];
      };

      default = self.packages.${system}.execline;
    };
  };
}
