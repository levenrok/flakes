{
  description = "Flake for Rust Development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , fenix
    ,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        toolchain = (fenix.packages.${system}.toolchainOf {
          channel = "nightly";
          date = "2026-03-21";
          sha256 = "sha256-rboGKQLH4eDuiY01SINOqmXUFUNr9F4awoFZGzib17o=";
        }).withComponents [
          "cargo"
          "clippy"
          "rustc"
          "rustfmt"
          "rust-analyzer"
          "rust-src"
          "llvm-tools-preview"
          "rustc-codegen-cranelift-preview"
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          name = "rust";

          nativeBuildInputs = [
            toolchain
            pkgs.mold
          ];

          env.RUST_SRC_PATH = "${toolchain}/lib/rustlib/src/rust/library";

          shellHook = ''
            echo -e "\033[0;32mDone!\033[0m"
          '';
        };
      }
    );
}
