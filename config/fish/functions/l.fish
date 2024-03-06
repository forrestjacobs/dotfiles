if type -q bat
  function l --wraps bat
    bat -p $argv
  end
else
  function l --wraps $PAGER
    $PAGER $argv
  end
end