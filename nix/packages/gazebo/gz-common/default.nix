{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "gz-common";
  version = "5.7.1";

  src = pkgs.fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-common";
    rev = "09422362651531d6013e3c25f990e8b82bf9b592";
    hash = "sha256-i0MJlbapQDVjb7RhfXao2XJWUYuET0AIw5xinvo5G+0=";
  };

  propagatedBuildInputs = with pkgs; [
    assimp
    ffmpeg
    freeimage
    gdal
    spdlog
    tinyxml-2
    util-linux # For uuid
    gz-cmake
    gz-math
    gz-utils
    gts
  ];

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
  ];

  meta = with pkgs.lib; {
    maintainers = [ "Nate Koenig <natekoenig@gmail.com>" ];
    description = "Gazebo common utilities";
    license = licenses.bsd3;
  };
}

