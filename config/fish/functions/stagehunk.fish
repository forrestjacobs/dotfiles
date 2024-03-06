function stagehunk --argument-names=needle
  git diff -U1 | grepdiff "$needle" --output-matching=hunk | git apply --cached
end
