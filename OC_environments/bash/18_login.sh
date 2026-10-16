#!/usr/bin/env bash
# Задача 18. Учебная имитация: пароль НЕ проверяется.
read -r -p 'Логин: ' login
read -r -s -p 'Пароль: ' password
printf '\n'
unset password
printf 'Пользователь %s авторизован\n' "$login"
