# [Hello Plutarch](https://github.com/tweag/hello-plutarch)

Hello Plutarch helps you writing projects in Haskell that use
[Plutarch](https://github.com/Plutonomicon/plutarch-plutus) libraries.

To start a new project based on Hello Plutarch, you need either
[nix](https://nixos.org) or [cabal](https://www.haskell.org/cabal/).

## Compile with nix

To avoid building components (and hence speed up compile time),
you must set up your nix cache properly, see
[here](https://input-output-hk.github.io/haskell.nix/tutorials/getting-started.html#setting-up-the-binary-cache)
and [there](https://github.com/input-output-hk/plutus#how-to-set-up-the-iohk-binary-caches).

To test the setup,

```sh
$ nix run
(program 1.0.0 (\i0 -> \i0 -> \i0 -> ()))
```

## Compile with cabal

Additional requirements:
- ghc (>= 9.2)
- pkg-config
- libsodium
- secp256k1

```sh
$ cabal run
(program 1.0.0 (\i0 -> \i0 -> \i0 -> ()))
```
