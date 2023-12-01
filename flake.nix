{
  inputs.nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";
  outputs = {
    self,
    nixpkgs-stable,
    ...
  } @ inputs: {
    packages.x86_64-linux = let
      pkgs = nixpkgs-stable.legacyPackages.x86_64-linux;
    in {
      execline = pkgs.buildEnv {
        name = "execlineb";
        paths = [];
        postBuild = ''
          mkdir -p $out/bin
          ln -s ${pkgs.execline}/bin/execlineb $out/bin/
          ln -s ${pkgs.execline}/bin/execline-cd $out/bin/
        '';
      };
    };
    default = self.packages.x86_64-linux.execline;
  };
}
