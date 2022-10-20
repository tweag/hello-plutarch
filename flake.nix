{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux; in
    let hpkgs = pkgs.haskell.packages.ghc92; in

    {
      devShells.x86_64-linux.default = self.devShell;

      devShell = pkgs.stdenv.mkDerivation {
        src = self;
        name = "devshell";
        buildInputs = [
          ## Haskell Packages
          hpkgs.ghc
          hpkgs.cabal-install
          hpkgs.hpack
          hpkgs.haskell-language-server
          ## Nixpkgs
          pkgs.pkg-config ## required to find system packages
          pkgs.libsodium ## required by `cardano-crypto-class` (at least)
          pkgs.secp256k1 ## required by `cardano-crypto-class` (at least)
        ];
      };
    };
}
