{ lib
, pkgs
, python3Packages
}:

with python3Packages;
buildPythonPackage rec {
  pname = "django-crispy-forms";
  version = "1.14.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "35887b8851a931374dd697207a8f56c57a9c5cb9dbf0b9fa54314da5666cea5b";
  };

  /*
  propagatedBuildInputs = [ django ];
  checkInputs = [ pytest pytest-cov pytest-django ];
  checkPhase = ''
    python -W error::DeprecationWarning -W error::PendingDeprecationWarning -m pytest --cov=crispy_forms
  '';
  */

  propagatedBuildInputs = [ django_3 ];

  doCheck = false;

  pythonImportsCheck = [ "crispy_forms" ];

  meta = with lib; {
    description = "The best way to have Django DRY forms";
    homepage = "https://github.com/django-crispy-forms/django-crispy-forms";
    license = licenses.mit;
  };
}

