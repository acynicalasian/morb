# For packages not managed by home-manager.

{ config, pkgs, modulesPath, ... }:

{
  imports = [
    /etc/nixos/configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    nil
    nixfmt
  ];

  environment.shellAliases = import ./alias.nix;

  users.defaultUserShell = pkgs.fish;

  programs.fish.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
