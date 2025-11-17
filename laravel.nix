{
  description = "Flake for Laravel";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "laravel";

        packages = with pkgs; [
          nodejs_24
          (php84.withExtensions
            (
              { enabled, all }: enabled ++ (with all; [
                opcache
                xdebug
                pdo_sqlite
              ])
            ))
          php84Packages.composer
        ];

        shellHook = ''
          echo -e "\033[0;36mSetting up Laravel environment...\033[0m"
          export PATH="$PATH:$HOME/.config/composer/vendor/bin"
          if command -v laravel &> /dev/null; then
              echo -e "\033[0;32mFound the Laravel Binary!\033[0m"
          else
              echo -e "\033[0;33mCannot Find the Composer Binary! Installing...\033[0m"
              composer global require laravel/installer --quiet
          fi
          echo -e "\033[0;32mDone!\033[0m"
        '';
      };
    };
}
