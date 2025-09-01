{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation rec {
  pname = "gz-msgs";
  version = "10.3.2";

  src = pkgs.fetchFromGitHub {
    owner = "gazebosim";
    repo = "gz-msgs";
    rev = "ebdd05f6d51c990876085bcc9db9f79df59d375a";
    hash = "sha256-ysKT9iKWJpMyzJ5tTzPP8Faetgn1d+5Xi7O1UMUJ8JA=";
  };

  # TODO: can be solved differently in cmake?
  postPatch = ''
    # Fix library location path construction
    substituteInPlace core/src/cmd/CMakeLists.txt \
      --replace 'set(library_location "../../../' \
                'set(library_location "'
  '';

  propagatedBuildInputs = with pkgs; [
    python3
    python3Packages.protobuf
    tinyxml-2
    gz-cmake
    gz-math
    gz-tools
  ];

  nativeBuildInputs = [
    pkgs.cmake
    pkgs.pkg-config
  ];

  # postInstall = ''
  #   mkdir -p $out/bin
  #   ln -s $out/libexec/gz/msgs${pkgs.lib.versions.major version}/gz-msgs $out/bin/
  # '';

  meta = with pkgs.lib; {
    maintainers = [ "Carlos Agüero <caguero@openrobotics.org>" ];
    description = "Gazebo Messages utilities";
    license = licenses.bsd3;
    mainProgram = "gz-msgs";
  };
}
