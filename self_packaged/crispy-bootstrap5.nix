{ lib
, pkgs
, python3Packages
}:

with python3Packages;
buildPythonPackage rec {
  pname = "crispy-bootstrap5";
  version = "0.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "e8c50daaf266d6127c7414f5669d5f2467b640d08b045ed9dd57e351d30609ae";
  };

  propagatedBuildInputs = [ django_3 (pkgs.callPackage ./django-crispy-forms.nix {})];

  doCheck = false;

  pythonImportsCheck = [ "crispy_bootstrap5" ];

  meta = with lib; {
    description = "Bootstrap5 template pack for django-crispy-forms";
    homepage = "https://github.com/django-crispy-forms/crispy-bootstrap5";
    license = licenses.mit;
  };
}

