{
  description = "Flake for Python Development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages."${system}";

      pyenv = ".venv";
      pyenv_bin = "${pyenv}/bin/activate";
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "python";

        nativeBuildInputs = with pkgs;[
          (python3.withPackages (pypkgs: with pypkgs; [
            pip
          ]))
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
    };
}
