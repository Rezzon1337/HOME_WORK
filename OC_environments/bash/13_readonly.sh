#!/usr/bin/env bash
# Задача 13: попытка изменить readonly (ожидаемая ошибка).
readonly LOCKED='original'
if ( LOCKED='changed' ); then
  printf 'Неожиданно: readonly удалось изменить\n'
else
  printf 'Переменная осталась равна: %s\n' "$LOCKED"
fi
TEMP_VAR='обычная'
unset TEMP_VAR
printf 'После unset: %s\n' "${TEMP_VAR-не задана}"
