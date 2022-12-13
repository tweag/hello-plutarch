# [Hello Plutarch](https://github.com/tweag/hello-plutarch)

Hello Plutarch helps you writing projects in Haskell that use
[Plutarch](https://github.com/Plutonomicon/plutarch-plutus) libraries.

To start a new project based on Hello Plutarch, you need either
[Nix](https://nixos.org) or [Cabal](https://www.haskell.org/cabal/).

## Compile with Nix

_You must answer positively to the questions prompted by the following Nix
command to avoid compiling GHC several times._

```console
$ nix run
(program 1.0.0 (\i0 -> \i0 -> \i0 -> ()))
```

## Compile with Cabal

Additional requirements:
- ghc (>= 9.2)
- pkg-config
- libsodium
- secp256k1

```console
$ cabal run
(program 1.0.0 (\i0 -> \i0 -> \i0 -> ()))
```

## Nix template

You can also use Nix to initialise a new Plutarch project with

```console
$ nix flake init -t github:tweag/hello-plutarch/template
```

## License

This template is licensed under the MIT license.
See the [LICENSE](LICENSE) file for more information.
