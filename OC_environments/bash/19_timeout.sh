#!/usr/bin/env bash
# Задача 19: read -t 5. Работает в интерактивном терминале.
if read -r -t 5 -p 'Введите значение за 5 секунд: ' value; then
  printf 'Введено: %s\n' "$value"
else
  code=$?
  if (( code > 128 )); then
    printf '\nВремя вышло\n'
  else
    printf '\nВвод прерван или недоступен\n' >&2
    exit 1
  fi
fi
