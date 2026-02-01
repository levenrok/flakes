{
  description = "Flake for Web Development with JavaScript";

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
          name = "javascript";

          nativeBuildInputs = with pkgs; [
            nodejs_24

            typescript-language-server
            tailwindcss-language-server
          ];

          shellHook = ''
            echo -e "\033[0;32mDone!\033[0m"
          '';
        };
      }
    );
}
