{
  description = "Flake Template for Development Environments";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "";

          nativeBuildInputs = [ ];

          buildInputs = [ ];

          env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ ];

          shellHook = '''';
        };
      }
    );
}
