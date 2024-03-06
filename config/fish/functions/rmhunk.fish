function rmhunk --argument-names=needle
  git diff -U1 | grepdiff "$needle" --output-matching=hunk | git apply -R
end
