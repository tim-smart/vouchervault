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
      buildToolsVersion = "34.0.0";
      androidComposition = pkgs.androidenv.composeAndroidPackages {
        buildToolsVersions = [buildToolsVersion "28.0.3"];
        platformVersions = ["34" "28"];
        abiVersions = ["armeabi-v7a" "arm64-v8a"];
      };
      androidSdk = androidComposition.androidsdk;
      flutter_path = "$PWD/.flutter";
      flutter = import ./nix/flutter.nix {
        inherit pkgs system;
        path = flutter_path;
      };
    in {
      devShell = with pkgs;
        mkShellNoCC {
          ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
          buildInputs = [
            androidSdk
            cocoapods
            jdk17
            ruby
          ];
          shellHook = ''
            ${flutter.unpack}/bin/unpack
            export PATH="${flutter_path}/flutter/bin:$PATH"
          '';
        };
    });
}
