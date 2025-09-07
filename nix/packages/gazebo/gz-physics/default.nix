{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "gz-physics";
  version = "7.5.0";

  src = pkgs.fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-physics";
    rev = "f29fd32a64036acec4482946be628b28ed5b08ed";
    hash = "sha256-w8u28lAAOHvBjbBkdmUmNkg3zmTLHrXSAEJC7v/EtKg=";
  };

  propagatedBuildInputs = with pkgs; [
    eigen
    dartsim
    # libdart / dartsim TODO
    # gz-physics> -- -------------------------------------------
    # gz-physics> CMake Warning at /nix/store/11s1rpm3qx0gg6vjb1zvky4afrja17iv-gz-cmake-4.1.1/share/cmake/gz-cmake4/cmake4/GzConfigureBuild.cmake:59 (message):
    # gz-physics>    CONFIGURATION WARNINGS:
    # gz-physics>    -- Skipping component [dartsim]: Missing dependency [DART] (Components: collision-bullet, collision-ode, utils, utils-urdf).
    # gz-physics>       ^~~~~ Set SKIP_dartsim=true in cmake to suppress this warning.
    # gz-physics> Call Stack (most recent call first):
    # gz-physics>   CMakeLists.txt:107 (gz_configure_build)
    bullet
    gz-cmake
    gz-common
    gz-math
    gz-plugin
    gz-utils
    sdformat
  ];

  nativeBuildInputs = [ pkgs.cmake pkgs.pkg-config];

  meta = with pkgs.lib; {
    maintainers = [ "Steve Peters <scpeters@openrobotics.org>" ];
    description = "Gazebo Physics utilities";
    license = licenses.bsd3;
  };
}

