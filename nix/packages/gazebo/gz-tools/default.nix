{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "gz-tools";
  version = "2.0.3";

  src = pkgs.fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-tools";
    rev = "c9ad7217c76ba434e0486842f8864d20c9cdfa32";
    hash = "sha256-xMFJylj7OnDc7zVWiI4a/mvNpu9scz83F3bGopCt8l8=";
  };

  propagatedBuildInputs = with pkgs; [
    gz-cmake
    ruby    # Provides Ruby runtime.
    rubocop
  ];

  nativeBuildInputs = with pkgs; [
    python3
    cmake
    pkg-config
    makeWrapper
  ];

  # Set LD_LIBRARY_PATH to include the library directory (libgz-tools2-backward.so discovery)
  postFixup = ''
    wrapProgram $out/bin/gz \
      --prefix LD_LIBRARY_PATH : "$out/lib"
  '';

  meta = with pkgs.lib; {
    maintainers = [ "Carlos Agüero <caguero@openrobotics.org>" ];
    description = "Gazebo Tools utilities";
    license = licenses.bsd3;
  };
}

