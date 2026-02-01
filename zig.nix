{
  description = "Flake for Zig Development";

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
          name = "zig";

          nativeBuildInputs = with pkgs; [
            zig

            zls
          ];

          shellHook = ''
            export ZIG_GLOBAL_CACHE_DIR="$PWD/.cache/zig";
            export ZIG_LOCAL_CACHE_DIR="$PWD/.zig-cache";

            echo -e "\033[0;32mDone!\033[0m"
          '';
        };
      }
    );
}
