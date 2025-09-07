{ lib, fetchPypi, python312Packages }:

python312Packages.buildPythonPackage rec {
  pname = "pyulog";
  version = "1.2.0";
  format = "setuptools";
  buildInputs = with python312Packages; [
    numpy
  ];
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-DfpSIl8b/AVRKUzRlahjgGAc3QcRIM8qBTNukU/ULsY=";
  };
  pythonImportsCheck = [ "pyulog" ];
  meta = with lib; {
    homepage = "https://github.com/PX4/pyulog";
    description = "Python module & scripts for ULog files.";
    maintainers = with maintainers; [ ];
    license = licenses.bsd3;
  };
}


