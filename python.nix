{
  description = "Flake for Python";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages."${system}";

      pyenv = ".venv/bin/activate";
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "python";

        packages = [
          (pkgs.python3.withPackages (pypkgs: with pypkgs; [
            python-lsp-server
            pip
          ]))
        ];

        env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
          pkgs.stdenv.cc.cc.lib
          pkgs.libz
        ];

        shellHook = ''
            if [[ ! -d .venv ]]; then
                python3 -m venv .venv
            fi

            source ${pyenv}
        '';
      };
    };
}
