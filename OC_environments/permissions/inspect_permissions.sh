#!/usr/bin/env bash
# Проверка кода и символьных прав для всех переданных путей.
set -euo pipefail
if (( $# == 0 )); then
  printf 'Использование: %s file1 [file2 ...]\n' "$0" >&2
  exit 2
fi
for path in "$@"; do
  if [[ -e $path || -L $path ]]; then
    stat -c '%n | тип=%F | владелец=%U:%G | код=%a | права=%A' -- "$path"
  else
    printf 'Не существует: %s\n' "$path" >&2
  fi
done
