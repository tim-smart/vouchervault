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
        config = {
          android_sdk.accept_license = true;
          allowUnfree = true;
        };
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
            export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
            mkdir -p android/keys
            sops -d secrets/fastlane-google-key > android/keys/google.json
          '';
        };
    });
}
