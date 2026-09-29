{
  l = "ls -alh";
  ll = "ls -l";
  ls = "ls --color=tty";
  cls = "ls -ahl --color=always";
  xls = "cls | less -R";
  cless = "less -R";

  rebuild-vm = "sudo nixos-rebuild switch --flake .#nixos --impure; sudo home-manager --flake .#akim@nixos";
}
