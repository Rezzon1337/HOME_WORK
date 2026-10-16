#!/usr/bin/env bash
# Задача 7: $0, $$ и $? (код необходимо сохранить сразу).
true
last_status=$?
printf 'Имя скрипта: %s\n' "$0"
printf 'PID скрипта: %s\n' "$$"
printf 'Код возврата последней команды (true): %s\n' "$last_status"
