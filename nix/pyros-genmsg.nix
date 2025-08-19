{ pyPkgs, fetchPypi, lib }:
pyPkgs.buildPythonPackage rec {
 name = "pyros-genmsg";
  format = "setuptools";
  version = "0.5.8";
  src = fetchPypi {
    pname = "pyros_genmsg";
    inherit version;
    sha256 = "sha256-PBywfZxA+eYIcph+7Jg6rFvbWSDqd5gDA/scRsMI9Hg=";
  };
}
