{ pkgs, ... }: {
  programs = {
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
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
    fd.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f";
    };
    git = {
      enable = true;
      includes = [
        { contents = import ./git.nix; }
      ];
    };
    jq.enable = true;
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    nix-index-database.comma.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = true;
      presets = [ "nerd-font-symbols" ];
      settings = {
        add_newline = false;
        palette = "catppuccin_frappe";
        palettes.catppuccin_frappe = {
          rosewater = "#f2d5cf";
          flamingo = "#eebebe";
          pink = "#f4b8e4";
          mauve = "#ca9ee6";
          red = "#e78284";
          maroon = "#ea999c";
          peach = "#ef9f76";
          yellow = "#e5c890";
          green = "#a6d189";
          teal = "#81c8be";
          sky = "#99d1db";
          sapphire = "#85c1dc";
          blue = "#8caaee";
          lavender = "#babbf1";
          text = "#c6d0f5";
          subtext1 = "#b5bfe2";
          subtext0 = "#a5adce";
          overlay2 = "#949cbb";
          overlay1 = "#838ba7";
          overlay0 = "#737994";
          surface2 = "#626880";
          surface1 = "#51576d";
          surface0 = "#414559";
          base = "#303446";
          mantle = "#292c3c";
          crust = "#232634";
        };
      };
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      autosuggestion.strategy = [
        "history"
        "completion"
      ];
      defaultKeymap = "emacs";
      fastSyntaxHighlighting.enable = true;
      history = {
        append = true;
        expireDuplicatesFirst = true;
        save = 50000; # iirc this is lines on disk
        saveNoDups = true;
        size = 50000; # iirc this is lines in mem
      };

    };
  };

  home.stateVersion = "25.11";
  home.sessionVariables = {
    EDITOR = "emacs";
    VISUAL = "emacs";
    PAGER = "less";
    LESS = "-FRX";
    DIRENV_LOG_FORMAT = "";
  };
}
