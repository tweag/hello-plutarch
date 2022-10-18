{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux; in

    {
      devShells.x86_64-linux.default = self.devShell;

      devShell = pkgs.stdenv.mkDerivation {
        src = self;
        name = "devshell";
        buildInputs = [
          pkgs.haskell.packages.ghc94.ghc
          pkgs.haskell.packages.ghc94.cabal-install
        ];
      };
    };
}
