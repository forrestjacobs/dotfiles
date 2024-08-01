if type -q eza
  function ls --wraps eza
    eza $argv
  end
end
