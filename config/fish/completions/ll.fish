if type -q eza
  complete --command ll --wraps eza
else
  complete --command ll --wraps ls
end
