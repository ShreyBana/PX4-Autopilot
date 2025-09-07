{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          pkgs,
          ...
        }:
        {
          devShells.default =
            let
              pyEnv = pkgs.python312.withPackages (
                p: with p; [
                  argcomplete
                  cerberus
                  coverage
                  ## Incompitble version in nixpkgs.
                  # empy
                  (pkgs.callPackage ./nix/empy.nix { pyPkgs = pkgs.python312Packages; })
                  future
                  jinja2
                  jsonschema
                  kconfiglib
                  lxml
                  matplotlib
                  numpy
                  nunavut
                  packaging
                  pandas
                  pkgconfig
                  psutil
                  pygments
                  wheel
                  pymavlink
                  # pyros-genmsg
                  (pkgs.callPackage ./nix/pyros-genmsg.nix { pyPkgs = pkgs.python312Packages; })
                  pyserial
                  # pyulog
                  (pkgs.callPackage ./nix/pyulog.nix { pyPkgs = pkgs.python312Packages; })
                  pyyaml
                  requests
                  setuptools
                  six
                  toml
                  sympy
                  pycryptodome
                  lark
                  python-lsp-server
                ]
              );
            in
            pkgs.mkShell {
              buildInputs = [ pyEnv ];
            };
        };
    };
}
