{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation rec {
  pname = "gz-gui";
  version = "8.4.0";

  src = pkgs.fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-gui";
    ## This rev is where the change the project name to `gz-gui` from `gz-gui10`.
    ## Need by `gz-launch`.
    rev = "ccace248522b36a5b15971013c9de5cf523b2831";
    hash = "sha256-k/GlT/hdRbEFdQzYM+0x4gr6CXFu1MXLyez5br8uRG4=";
  };

  # TODO: can be solved differently in cmake?
  postPatch = ''
    ## There's code which joins this path w/ the install directory, but the variable
    ## is already an absolute path(nix-store path).
    # substituteInPlace include/gz/gui/CMakeLists.txt \
    #   --replace-fail 'GZ_GUI_PLUGIN_RELATIVE_INSTALL_DIR="''${GZ_GUI_PLUGIN_RELATIVE_INSTALL_DIR}' \
    #                  'GZ_GUI_PLUGIN_RELATIVE_INSTALL_DIR="lib/${pname}-${pkgs.lib.versions.major version}/plugins'
    ## Fix library location path construction
    substituteInPlace src/cmd/CMakeLists.txt \
      --replace 'set(library_location "../../../' \
                'set(library_location "'
  '';

  buildInputs = with pkgs; [
    cppzmq
    protobuf_21
    tinyxml-2
  ];

  cmakeFlags = [
    "-DCMAKE_SKIP_BUILD_RPATH=ON"
    "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON"
    "-DCMAKE_INSTALL_RPATH=\$ORIGIN/../lib"
  ];

  propagatedBuildInputs = with pkgs; [
    gz-physics
    gz-common
    gz-math
    gz-msgs
    gz-plugin
    gz-rendering
    gz-tools
    gz-transport
    gz-utils
    qt5.qtbase
    qt5.qtquickcontrols2
    qt5.qtcharts
    qt5.qtgraphicaleffects
    qt5.qtlocation
    qt5.qtpositioning
    qt5.qtdeclarative
    # qt5.qtlabs.folderlistmodel
    # qt5.qtlabs.platform
    # qt5.qtlabs.settings
  ];

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    xorg.xvfb
    qt5.wrapQtAppsHook
  ];

  meta = with pkgs.lib; {
    maintainers = [ "Jenn Nguyen <jennuine@google.com>" ];
    description = "Gazebo GUI utilities";
    license = licenses.bsd3;
  };
}
