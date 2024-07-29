# /etc/nixos/packages/surrealdb-bin.nix 
{ stdenv, fetchzip, autoPatchelfHook, glibc, gcc-unwrapped }: stdenv.mkDerivation rec {
  pname = "surrealdb-bin";
  version = "1.5.3";

  src = fetchzip {
    url = "https://github.com/surrealdb/surrealdb/releases/download/v${version}/surreal-v${version}.linux-amd64.tgz";
    sha256 = "77iROE6FirzWMyXDeRqNOKciJRiMrFdwWnuSyBjvcEA=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ glibc gcc-unwrapped ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 surreal $out/bin
    runHook postInstall
  '';
}
