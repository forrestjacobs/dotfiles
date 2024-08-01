function l
  if ! set -q argv[1] || test -d $argv[1]
    ls -l $argv
  else if type -q bat
    bat -p $argv
  else
    $PAGER $argv
  end
end
