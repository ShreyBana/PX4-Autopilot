{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "gz-plugin";
  version = "2.0.4";

  src = pkgs.fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-plugin";
    rev = "25b10154cbe7a23e0bbf939fcc7cd63be39f70da";
    hash = "sha256-T4hkOJLzkerC3HmG/lNJDFZXycbrRj/5tq6ILO2Lo64=";
  };

  # TODO: can be solved differently in cmake?
  postPatch = ''
    # Fix library location path construction
    substituteInPlace loader/src/cmd/CMakeLists.txt \
      --replace 'set(plugin_exe_location "../../../' \
                'set(plugin_exe_location "'
  '';

  propagatedBuildInputs = with pkgs; [
    gz-cmake
    gz-tools
    gz-utils
  ];

  nativeBuildInputs = with pkgs; [
    python3
    cmake
    pkg-config
  ];

  postInstall = ''
    mkdir -p $out/bin
    ln -s $out/libexec/gz/plugin${pkgs.lib.versions.major version}/gz-plugin $out/bin/
  '';

  meta = with pkgs.lib; {
    maintainers = [ "Alejandro Hernández Cordero <ahcorde@gmail.com>" ];
    description = "Gazebo Plugin utilities";
    license = licenses.bsd3;
    mainProgram = "gz-plugin";
  };
}
