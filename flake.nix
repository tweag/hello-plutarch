{
  description = "A template for Plutarch";

  outputs = { self, nixpkgs }: {

      templates.default = {
          path = ./template;
          description = "A Plutarch project using `haskell.nix`";
          welcomeText = builtins.readFile ./README.md;
      };
  };
}
