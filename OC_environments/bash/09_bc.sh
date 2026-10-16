#!/usr/bin/env bash
# Задача 9: bc и степень в Bash.
if ! command -v bc >/dev/null 2>&1; then
  printf 'Ошибка: установите bc (например: sudo apt install bc).\n' >&2
  exit 1
fi
printf '10 / 3 = %s\n' "$(printf 'scale=2; 10/3\n' | bc)"
printf '2^10 = %s\n' "$((2 ** 10))"
