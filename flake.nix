{
  description = "Hello C";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    with flake-utils.lib;
    eachSystem allSystems (system:
      let pkgs = import nixpkgs { inherit system; };
      in rec {

        defaultPackage = pkgs.stdenv.mkDerivation rec {
          name = "hello c";
          src = self;
          phases = [ "unpackPhase" "buildPhase" "installPhase" ];
          preBuild = ''
              
          '';
          buildInputs = [ pkgs.gcc];

          buildPhase = ''
             gcc main.c -o a.out
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp a.out $out/bin/thingy
          '';
        };
      });
}
