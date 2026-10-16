#!/usr/bin/env bash
# Задача 15: команда -v и stderr.
if ! command -v git >/dev/null 2>&1; then
  printf 'Ошибка: git не установлен.\n' >&2
  exit 1
fi
git --version
