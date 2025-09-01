{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "gz-cmake";
  version = "3.5.5";

  src = pkgs.fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-cmake";
    rev = "c59f1107b46e21df6e041c68af1d4a4124502a20";
    hash = "sha256-uUYmDVyKN6LNBCbVj0qFvhLRH+tI3v33hcE5lStAiW0=";
  };

  nativeBuildInputs = with pkgs; [
    python3
    cmake
    pkg-config
  ];

  meta = with pkgs.lib; {
    maintainers = [ "Steve Peters <scpeters@openrobotics.org>" ];
    description = "Gazebo cmake utilities";
    license = licenses.bsd3;
  };
}

