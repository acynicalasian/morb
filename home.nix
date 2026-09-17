{ config, pkgs, ... }:

# This file is mostly intended to be a top-down view of the packages
# I'm using and the settings I'm extending.
{
  imports =
    [
      /etc/nixos/configuration.nix
      ./pkgcfg.nix
    ];

  # Add additional system packages.
  environment.systemPackages = with pkgs; [
      emacs
      fish
      delta    # fancy git diff viewer
    ];

  environment.shellAliases = import ./alias.nix;

  users.defaultUserShell = pkgs.fish;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}