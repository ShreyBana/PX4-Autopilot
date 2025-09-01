{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "sdformat";
  version = "14.8.0";

  src = pkgs.fetchFromGitHub {
    owner = "gazebosim";
    repo = "sdformat";
    rev = "a6cbe26aa81367412e88187349578fc4485b0b01";
    hash = "sha256-ICH28nKcgXegu3t3Do1gb0ScyJ43ukHy7F/jLbLq/Dw=";
  };

  # TODO: https://github.com/gazebosim/gz-gui/pull/614 - can be solved differently?
  postPatch = ''
    # Fix library location path construction
    substituteInPlace src/cmd/CMakeLists.txt \
      --replace 'set(library_location "../../../' \
                'set(library_location "'
  '';

  buildInputs = with pkgs; [
    python311Packages.pybind11
    tinyxml-2
    urdfdom
  ];

  propagatedBuildInputs = with pkgs; [
    gz-cmake
    gz-math
    gz-utils
  ];

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    libxml2
    python3Packages.psutil
    python3Packages.pytest
  ];

  meta = with pkgs.lib; {
    maintainers = [
      "Addisu Z. Taddese <addisu@openrobotics.org>"
      "Steve Peters <scpeters@openrobotics.org>"
    ];
    description = "Gazebo SDFormat utilities";
    license = licenses.bsd3;
  };
}

