#!/usr/bin/env bash
# Задача 16: регистр строки и длина в символах (зависит от UTF-8 locale).
read -r -p 'Введите строку: ' line
printf 'Верхний регистр: %s\n' "${line^^}"
printf 'Нижний регистр: %s\n' "${line,,}"
printf 'Длина (символы): %s\n' "${#line}"
