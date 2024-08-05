{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      flutter_path = "$PWD/.flutter";
      flutter = import ./nix/flutter.nix {
        inherit pkgs system;
        path = flutter_path;
      };
    in {
      devShell = with pkgs;
        mkShellNoCC {
          buildInputs = [
            cocoapods
            jdk17
            ruby
            sops
          ];
          shellHook = ''
            ${flutter.unpack}/bin/unpack
            export PATH="${flutter_path}/flutter/bin:$PATH"
            mkdir -p android/keys
            sops -d secrets/fastlane-google-key android/keys/google.json
          '';
        };
    });
}
