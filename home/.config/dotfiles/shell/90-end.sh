#!/bin/sh

: "${shell:?}"

p_source fzf "--${shell}"
p_source starship init "${shell}" --print-full-init
p_source zoxide init "${shell}"
