{
  pkgs ? import <nixpkgs> {},
  path,
  system,
}: rec {
  source =
    if system == "aarch64-darwin"
    then
      pkgs.fetchurl {
        url = "https://storage.googleapis.com/flutter_infra_release/releases/betc/macos/flutter_macos_arm64_3.24.0-0.2.pre-beta.zip";
        hash = "";
      }
    else if system == "x86_64-darwin"
    then
      pkgs.fetchurl {
        url = "https://storage.googleapis.com/flutter_infra_release/releases/beta/macos/flutter_macos_3.24.0-0.2.pre-beta.zip";
        hash = "sha256-AbeSWHYRORM74qM9W4v0pyQ9Wc/DO8FJejR2QwReEgY=";
      }
    else abort "unsupported system";

  unpack = pkgs.writeShellApplication {
    name = "unpack";
    runtimeInputs = with pkgs; [unzip];
    text = ''
      flutter_local_dir=${path}
      flutter_bin_dir="$flutter_local_dir"/flutter/bin
      flutter_bin_file="$flutter_bin_dir"/flutter

      echo "flutter needs local installation? ..."

      if [ -f "$flutter_bin_file" ]; then
        echo "flutter is already installed locally in '$flutter_local_dir'"
      else
        echo "... installing flutter locally in '$flutter_local_dir'"
        unzip ${source} -d "$flutter_local_dir"
      fi
    '';
  };
}
