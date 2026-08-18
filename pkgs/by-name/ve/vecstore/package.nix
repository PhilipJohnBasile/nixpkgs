{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  protobuf,
  unstableGitUpdater,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "vecstore";
  version = "0.1.0-unstable-2026-07-10";

  src = fetchFromGitHub {
    owner = "PhilipJohnBasile";
    repo = "vecstore";
    rev = "82fb7c5e572c5d9aca73ff5facdc5365d9133503";
    hash = "sha256-hC5XozSG9gQs962ryPywW+t4i5DlRXe2tUig+cL8oyg=";
  };

  cargoLock.lockFile = "${finalAttrs.src}/Cargo.lock";

  nativeBuildInputs = [
    pkg-config
    protobuf
  ];

  buildFeatures = [ "server" ];

  cargoBuildFlags = [
    "--bin"
    "vecstore-server"
  ];

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    description = "Embeddable vector database with HNSW search and RAG tooling";
    homepage = "https://github.com/PhilipJohnBasile/vecstore";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.philipjohnbasile ];
    mainProgram = "vecstore-server";
    platforms = lib.platforms.unix;
  };
})
