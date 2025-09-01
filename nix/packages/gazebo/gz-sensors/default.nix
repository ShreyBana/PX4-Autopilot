{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "gz-sensors";
  version = "8.2.2";

  src = pkgs.fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-sensors";
    rev = "520d266ec1737e1f74b36437d3b6b3eedff75efd";
    hash = "sha256-9hiz4vmCHjfjsFM1r2eadyY3VZI8c4mz6BFvTYKrADQ=";
  };

  buildInputs = with pkgs; [
    zlib
    cppzmq
    libGL
  ];

  propagatedBuildInputs = with pkgs; [
    gz-common
    gz-math
    gz-msgs
    gz-rendering
    gz-tools
    gz-transport
    sdformat
  ];

  nativeBuildInputs = [ pkgs.cmake pkgs.pkg-config pkgs.xorg.xvfb];

  meta = with pkgs.lib; {
    maintainers = [ "Ian Chen <ichen@openrobotics.org>" ];
    description = "Gazebo Sensors utilities";
    license = licenses.bsd3;
  };
}

