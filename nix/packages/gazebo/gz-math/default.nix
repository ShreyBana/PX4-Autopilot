{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "gz-math";
  version = "7.5.2";

  src = pkgs.fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-math";
    rev = "ad7e7cddc729e509663f2c7695f9590ce4f6cc4f";
    hash = "sha256-femdxrCUfQd5dJXN99sHdhSkGV9cVYNCfs7jktFeqhU=";
  };

  propagatedBuildInputs = with pkgs; [
    eigen
    python311Packages.pybind11
    gz-cmake
    gz-utils
  ];

  nativeBuildInputs = [ pkgs.cmake pkgs.pkg-config];

  meta = with pkgs.lib; {
    maintainers = [
      "Steve Peters <scpeters@openrobotics.org>"
      "Aditya Pande <aditya050995@gmail.com>"
    ];
    description = "Gazebo Math utilities";
    license = licenses.bsd3;
  };
}

