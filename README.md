# Nix Flakes

This repository contains a List of Nix Flakes for configuring development environments for various programming languages. It also includes a shell script that can be used to easily configure the environment.

## Usage

1. Clone the repository
```sh
git clone https://github.com/levenrok/flakes.git
cd flakes
```

2. Make the script globally accessible
```sh
ln -s $(pwd)/setup-devenv ~/.local/bin/setup-devenv
```

> [!WARNING]
> Directory `~/.local/bin` is not included in the `$PATH` of most distributions. To make it accessible add following line to your `.bashrc`, or use anothor location like `/usr/local/bin` that's already included.
> ```sh
> # Local Binaries
> export PATH="$PATH:$HOME/.local/bin"
> ```

3. Invoke the script
```sh
setup-devenv
```