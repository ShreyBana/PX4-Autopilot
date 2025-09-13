{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    gz-overlay.url = "github:shreybana/gazebo-sim-overlay/use-protobuf-21";
    nixpkgs.url = "github:NixOS/nixpkgs/25.05";
  };
  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
      ];
      systems = [
        "x86_64-linux"
      ];
      perSystem =
        {
          pkgs,
          system,
          ...
        }:
        let
          pyEnv = pkgs.python312.withPackages (
            p: with p; [
              argcomplete
              cerberus
              coverage
              ## Incompitble version in nixpkgs.
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
              (pkgs.callPackage ./nix/pyros-genmsg.nix { pyPkgs = pkgs.python312Packages; })
              pyserial
              (pkgs.callPackage ./nix/pyulog.nix { pyPkgs = pkgs.python312Packages; })
              pyyaml
              requests
              setuptools
              six
              pyyaml
              toml
              sympy
              pycryptodome
              lark
              python-lsp-server
            ]
          );
          libs = with pkgs; [
            libuuid
            protobuf3_21
            cppzmq
            tinyxml-2
            eigen
            qt5.full
            ffmpeg-headless
            opencv
          ];
        in
        {
          devShells.default = pkgs.mkShell {
            packages = [
              pyEnv
              pkgs.cmake
              inputs.gz-overlay.legacyPackages.${system}.gz-harmonic
              inputs.gz-overlay.legacyPackages.${system}.sdformat_14
            ]
            ++ libs;
          };
        };
    };
}
