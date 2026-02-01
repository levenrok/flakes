{
  description = "Flake for Go Development";

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
          name = "go";

          nativeBuildInputs = with pkgs; [
            go

            gopls
          ];

          shellHook = ''
            echo -e "\033[0;32mDone!\033[0m"
          '';
        };
      }
    );
}
