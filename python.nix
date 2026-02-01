{
  description = "Flake for Python Development";

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
          name = "python";

          nativeBuildInputs = with pkgs; [
            (python3.withPackages (
              pypkgs: with pypkgs; [
                pip
              ]
            ))
            basedpyright
          ];

          buildInputs = with pkgs; [
            zlib
          ];

          env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
            pkgs.stdenv.cc.cc.lib
            pkgs.zlib
          ];

          shellHook = ''
            echo -e "\033[0;32mDone!\033[0m"
          '';
        };
      }
    );
}
