{
  inputs.nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";
  outputs = {
    self,
    nixpkgs-stable,
    ...
  } @ inputs: {
    packages.x86_64-linux.execline = inputs.nixpkgs-stable.legacyPackages.x86_64-linux.buildEnv {
      name = "execlineb";
      paths = [];
      postBuild = ''
        mkdir -p $out/bin
        ln -s ${inputs.nixpkgs-stable.legacyPackages.x86_64-linux.execline}/bin/execlineb $out/bin/
        ln -s ${inputs.nixpkgs-stable.legacyPackages.x86_64-linux.execline}/bin/execline-cd $out/bin/
      '';
    };
  };
}
