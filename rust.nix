{
  description = "Flake for Rust Development";

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
        name = "rust";

        nativeBuildInputs = with pkgs ;[
          cargo
          rustc

          rust-analyzer
          rustfmt
          clippy
        ];

        env.RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

        shellHook = ''
          echo -e "\033[0;32mDone!\033[0m"
        '';
      };
    };
}
