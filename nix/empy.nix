{ pyPkgs, fetchPypi, lib }:
pyPkgs.buildPythonPackage rec {
 name = "empy";
  format = "setuptools";
  version = "3.3.4";
  src = fetchPypi {
    pname = name;
    inherit version;
    sha256 = "sha256-c6xJeFtgFHnfTqGKfHm8EwSop8NMArlHLPEgauiPAbM=";
  };
}
