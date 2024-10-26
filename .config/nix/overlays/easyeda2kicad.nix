final: prev: {
  easyeda2kicad = prev.python3.pkgs.buildPythonPackage rec {
    pname = "easyeda2kicad";
    version = "0.8.0";
    format = "pyproject";
  
    src = prev.python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "0jsa9w8fmdhvv5nrsw2cvqhrj34kxdrj6ad4hrlf1xkn21nvx0d7";
    };

    nativeBuildInputs = with prev.python3.pkgs; [
      setuptools
      pip
      wheel
    ];
  
    propagatedBuildInputs = with prev.python3.pkgs; [
      requests
      pydantic
    ];
  
    meta = with prev.lib; {
      description = "Convert EasyEDA PCB files to KiCad format";
      homepage = "https://github.com/luxuryy/easyeda2kicad";
      license = licenses.mit;
      maintainers = [ ];
    };
  };
}
