{
  lib,
  buildPythonPackage,
  callPackage,
  fetchFromGitHub,
  setuptools,
}:

let
  test-vectors = callPackage ./vectors.nix { };
in
buildPythonPackage (finalAttrs: {
  pname = "pycryptodome";
  version = "4.5.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Legrandin";
    repo = "pycryptodome";
    tag = "v${finalAttrs.version}";
    hash = "sha256-/gYY20DCNfKCi0f5tnY9KJmufEY3axbCDKpgu8E8x9k=";
  };

  build-system = [ setuptools ];

  nativeCheckInputs = [ test-vectors ];

  pythonImportsCheck = [ "Crypto" ];

  meta = {
    description = "Self-contained cryptographic library";
    homepage = "https://github.com/Legrandin/pycryptodome";
    changelog = "https://github.com/Legrandin/pycryptodome/blob/${finalAttrs.src.tag}/Changelog.rst";
    license = with lib.licenses; [
      bsd2 # and
      asl20
    ];
    maintainers = with lib.maintainers; [ fab ];
  };
})
