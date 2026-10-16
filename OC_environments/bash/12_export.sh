#!/usr/bin/env bash
# Задача 12: локальная переменная не передаётся подпроцессу.
unset MYVAR
MYVAR='secret'
printf 'Без export: '
bash -c 'printf "%s\n" "${MYVAR:-<пусто>}"'
export MYVAR
printf 'С export: '
bash -c 'printf "%s\n" "${MYVAR:-<пусто>}"' 
