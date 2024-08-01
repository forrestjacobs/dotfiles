if type -q eza
  function ll --wraps eza
    eza -aagl $argv
  end
else
  function ll --wraps ls
    ls -al $argv
  end
end
