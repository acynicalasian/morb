{ pkgs, ... }: {
  programs = {
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
    direnv = {
      enable = true;
      enableFishIntegration = true;
      # enableGitIntegration = true;
    };
    emacs = {
      enable = true;
      package = pkgs.emacsWithPackagesFromUsePackage {
        package = pkgs.emacs;
        config = ./emacs.el;
        defaultInitFile = true;
        alwaysEnsure = true;
      };
    };
    git = {
      enable = true;
      includes = [
        { contents = import ./git.nix; }
      ];
    };
    fish.enable = true;
    jq.enable = true;
  };

  home.stateVersion = "25.11";
}
