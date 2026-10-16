#!/usr/bin/env bash
# Задача 8. Целочисленная арифметика Bash.
read -r -p 'Первое целое число: ' first
read -r -p 'Второе целое число: ' second
if [[ ! $first =~ ^-?[0-9]+$ || ! $second =~ ^-?[0-9]+$ ]]; then
  printf 'Ошибка: нужны два целых десятичных числа.\n' >&2
  exit 1
fi
# Основание 10, в том числе при ведущих нулях; для отрицательных чисел - знак отдельно.
as_decimal() {
  local input=$1
  if [[ $input == -* ]]; then
    printf '%s\n' "$((-10#${input#-}))"
  else
    printf '%s\n' "$((10#$input))"
  fi
}
a=$(as_decimal "$first")
b=$(as_decimal "$second")
printf 'Сумма: %s\n' "$((a + b))"
printf 'Разность: %s\n' "$((a - b))"
printf 'Произведение: %s\n' "$((a * b))"
if (( b == 0 )); then
  printf 'Частное: не определено (деление на 0)\nОстаток: не определён (деление на 0)\n'
else
  printf 'Частное (целое): %s\n' "$((a / b))"
  printf 'Остаток: %s\n' "$((a % b))"
fi
