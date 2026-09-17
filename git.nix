{
  init.defaultBranch = "main";
  pull.ff = "only";
  rerere.enabled = true;
  core.pager = "delta";
  interactive.diffFilter = "delta --color-only";
  delta.navigate = true;
  delta.dark = true;
  merge.conflictStyle = "zdiff3";
  diff.algorithm = "histogram";
  core.editor = "emacs";
}