{
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:

      let pkgs = nixpkgs.legacyPackages.${system}; in
      let hpkgs = pkgs.haskell.packages.ghc92; in

      {
        devShells.default = pkgs.mkShell {
          packages = [
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
      }
    );
}
