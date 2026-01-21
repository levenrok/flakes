{
  description = "Flake for Zig Development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages."${system}";
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "zig";

        nativeBuildInputs = with pkgs;[
          zig

          zls
        ];

        shellHook = ''
          export ZIG_GLOBAL_CACHE_DIR="$PWD/.cache/zig";
          export ZIG_LOCAL_CACHE_DIR="$PWD/.zig-cache";

          echo -e "\033[0;32mDone!\033[0m"
        '';
      };
    };
}
