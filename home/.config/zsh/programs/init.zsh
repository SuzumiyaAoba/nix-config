#!/usr/bin/env zsh

setopt local_options null_glob

typeset -a program_files
program_files=("${HOME}/.config/zsh/programs/"*.zsh)

for program_file in "${program_files[@]}"; do
  if [[ "${program_file:t}" == "init.zsh" ]]; then
    continue
  fi

  source "${program_file}"
done

