{
  description = "Flake for Go";

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
        name = "go";

        nativeBuildInputs = with pkgs; [
          go
        ];

        shellHook = ''
          echo -e "\033[0;32mDone!\033[0m"
        '';
      };
    };
}
