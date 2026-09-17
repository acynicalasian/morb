{ config, pkgs, ... }:

{
  # Apparently if <name>.enable exists, it's good practice to use this
  # since it triggers additional dependency stuff automatically.
  programs.fish.enable = true;

  # If I understand correctly, the `.enable` attr on these apps also
  # automatically handles installation?
  programs.direnv.enable = true;
  programs.git.enable = true;

  # This file is intended to be a top-down view of the settings
  # I've changed.
  programs.git.config = import ./git.nix;
}