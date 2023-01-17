{
  inputs = {
    ## This version of haskell.nix allows to *copy* GHC 9.2.4
    haskellNix.url = "github:input-output-hk/haskell.nix?ref=0.0.68";
    nixpkgs.follows = "haskellNix/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    ## See https://input-output-hk.github.io/cardano-haskell-packages/
    CHaP = {
      url = "github:input-output-hk/cardano-haskell-packages?ref=repo";
      flake = false;
    };
  };

  outputs = { self, haskellNix, nixpkgs, flake-utils, CHaP }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      overlays = [ haskellNix.overlay
      (final: prev: {
        hello-plutarch =
          final.haskell-nix.project' {
            src = ./.;
            compiler-nix-name = "ghc924";
            inputMap = {
              "https://input-output-hk.github.io/cardano-haskell-packages" = CHaP;
            };
            shell.tools = {
              cabal = {};
              hlint = {};
              hpack = {};
              haskell-language-server = {};
            };
          };
        })
      ];
    pkgs = import nixpkgs { inherit system overlays; inherit (haskellNix) config; };
    flake = pkgs.hello-plutarch.flake {};
    in flake //
    {
      packages.default = flake.packages."hello-plutarch:exe:hello-plutarch";
    });

    nixConfig = {
      ## Setup IOG cache. See
      ## https://input-output-hk.github.io/haskell.nix/tutorials/getting-started.html#setting-up-the-binary-cache
      extra-trusted-substituters = ["https://cache.iog.io"];
      extra-trusted-public-keys = ["hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="];
      allow-import-from-derivation = "true";
    };
}
