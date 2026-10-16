#!/usr/bin/env bash
# Задача 17: коды возврата ls.
ls /nonexistent
bad_status=$?
printf 'Код ls /nonexistent: %s\n' "$bad_status"
ls / >/dev/null
good_status=$?
printf 'Код ls /: %s\n' "$good_status"
