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

        nativeBuildInputs = [
          (pkgs.python3.withPackages (pypkgs: with pypkgs; [
            pip

            jedi-language-server
          ]))
        ];

        buildInputs = with pkgs; [
          zlib
        ];

        env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
          pkgs.stdenv.cc.cc.lib
          pkgs.zlib
        ];

        shellHook = ''
          if [[ ! -d ${pyenv} ]]; then
              python3 -m venv ${pyenv}
          fi

          source ${pyenv_bin}

          echo -e "\033[0;32mDone!\033[0m"
        '';
      };
    };
}
