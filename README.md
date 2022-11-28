# [Hello Plutarch](https://github.com/tweag/hello-plutarch)

Hello Plutarch helps you writing projects in Haskell that use
[Plutarch](https://github.com/Plutonomicon/plutarch-plutus) libraries.

To start a new project based on Hello Plutarch, you need either
[nix](https://nixos.org) or [cabal](https://www.haskell.org/cabal/).

## Compile with nix

_You must answer positively to the questions prompted by the following nix
command to avoid compiling GHC several times._

```console
$ nix run
(program 1.0.0 (\i0 -> \i0 -> \i0 -> ()))
```

## Compile with cabal

Additional requirements:
- ghc (>= 9.2)
- pkg-config
- libsodium
- secp256k1

```console
$ cabal run
(program 1.0.0 (\i0 -> \i0 -> \i0 -> ()))
```
