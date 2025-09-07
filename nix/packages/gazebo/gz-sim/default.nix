{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation rec {
  pname = "gz-sim";
  version = "8.9.0";

  src = pkgs.fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-sim";
    rev = "3f8d77ba050b29b5cf4bc4a35da6009178812eaf";
    hash = "sha256-MCOwizpWHznfNpU/u4mle/RlMfbJiU60C7VgoM8Vuzs=";
  };

  # TODO: https://github.com/gazebosim/gz-sim/pull/2358 - can be solved differently?
  postPatch = ''
    # Fix library location path construction
    substituteInPlace src/cmd/CMakeLists.txt \
      --replace 'set(library_location "../../../' \
                'set(library_location "' \
      --replace 'set(model_exe_location "../../../' \
                'set(model_exe_location "'
  '';

  buildInputs = with pkgs; [
    freeglut
    freeimage
    glew
    cppzmq
    xorg.libXi.dev
    xorg.libXmu.dev
    protobuf_21
    python311Packages.pybind11
    tinyxml-2
    util-linux # For uuid support.
    libsodium
  ];

  propagatedBuildInputs = with pkgs; [
    gz-cmake
    gz-common
    gz-fuel-tools
    gz-gui
    gz-math
    gz-msgs
    gz-physics
    gz-plugin
    gz-rendering
    gz-sensors
    gz-tools
    gz-transport
    gz-utils
    sdformat
    qt5.qtbase
    qt5.qtquickcontrols2
  ];

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    xorg.xvfb
    qt5.wrapQtAppsHook
  ];

  postInstall = ''
    ln -s $out/lib/${pname}-${pkgs.lib.versions.major version}/plugins $out/plugins
  '';

  meta = with pkgs.lib; {
    maintainers = [ "Michael Carroll <mjcarroll@intrinsic.ai>" ];
    description = "Gazebo Simulator utilities";
    license = licenses.bsd3;
    mainProgram = "gz-sim-model";
  };
}
