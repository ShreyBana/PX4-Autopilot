{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "gz-utils";
  version = "2.2.1";

  src = pkgs.fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-utils";
    rev = "53eaee7fcfeeff6ee02246bf412b0298eefc54c4";
    hash = "sha256-ybPb8V2QFASi4WvXJl1xSr28BlBpfBjgoyx7MXkNVG4=";
  };

  propagatedBuildInputs = with pkgs; [
    cli11
    spdlog
    gz-cmake
  ];

  nativeBuildInputs = with pkgs; [
    python3
    cmake
    pkg-config
  ];

  meta = with pkgs.lib; {
    maintainers = [ "Addizu Z. Taddese <addisu@openrobotics.org>" ];
    description = "Gazebo Utilities";
    license = licenses.bsd3;
  };
}

