{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "gz-transport";
  version = "13.4.1";

  src = pkgs.fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-transport";
    rev = "419d6b568c83d629cc055a4c0165fbc69d03880c";
    hash = "sha256-VK4RSWuWlWd1Qps/LHM9n5UtHDr4Tb8LryX8GxHw2CM=";
  };

  # TODO: can be solved differently in cmake?
  postPatch = ''
    # Fix library location path construction
    substituteInPlace src/cmd/CMakeLists.txt \
      --replace 'set(service_exe_location "../../../' \
                'set(service_exe_location "' \
      --replace 'set(topic_exe_location "../../../' \
                'set(topic_exe_location "'

    substituteInPlace log/src/cmd/CMakeLists.txt \
      --replace 'set(log_library_location "../../../' \
                'set(log_library_location "'

    substituteInPlace parameters/src/cmd/CMakeLists.txt \
      --replace 'set(param_library_location "../../../' \
                'set(param_library_location "'
  '';

  buildInputs = with pkgs; [
    zlib
    cppzmq
    sqlite.dev
    protobuf
    python3Packages.pybind11
    python3
    python3Packages.psutil
    util-linux      # For uuid support.
    libsodium
  ];

  propagatedBuildInputs = with pkgs; [
    gz-cmake
    gz-math
    gz-msgs
    gz-tools
    gz-utils
  ];

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
  ];

  postInstall = ''
    mkdir -p $out/bin
    ln -s $out/libexec/gz/transport${pkgs.lib.versions.major version}/gz-transport-service $out/bin/
    ln -s $out/libexec/gz/transport${pkgs.lib.versions.major version}/gz-transport-topic $out/bin/
  '';

  meta = with pkgs.lib; {
    maintainers = [ "Carlos Agüero <caguero@openrobotics.org>" ];
    description = "Gazebo Transport utilities";
    license = licenses.bsd3;
  };
}

