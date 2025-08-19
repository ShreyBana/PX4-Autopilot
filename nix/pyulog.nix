{ pyPkgs }:
pyPkgs.buildPythonPackage rec {
  name = "pyulog";
  src = builtins.fetchGit {
    url = "https://github.com/PX4/pyulog.git";
    rev = "e328bd3359c0d2ef817cbc03491df44fe5e5c750";
  };
  pyproject = true;
  build-system = [ pyPkgs.setuptools-scm ];
  propagatedBuildInputs = with pyPkgs; [
    # ppkgs.setuptools
    numpy
  ];
  # prePatch = "sed -i -e 's/use_scm_version=scm_version..,//g' setup.py";
  SETUPTOOLS_SCM_PRETEND_VERSION = "1.2.2";
}
