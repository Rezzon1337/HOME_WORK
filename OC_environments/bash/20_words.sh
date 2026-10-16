#!/usr/bin/env bash
# Задача 20: read -a и индексирование массива.
read -r -a words -p 'Введите слова через пробел: '
for index in "${!words[@]}"; do
  printf '%d. %s\n' "$(( index + 1 ))" "${words[index]}"
done
