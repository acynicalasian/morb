{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: rec {
    myEmacs = pkgs.emacs.pkgs.withPackages (epkgs: with epkgs; [
        lsp-mode
	nixfmt
	
      ]);