#!/usr/bin/env bash
# Задача 14. Пустая или отсутствующая CONFIG вызывает завершение.
printf 'CONFIG: %s\n' "${CONFIG:?Ошибка: CONFIG не задана или пуста}"
