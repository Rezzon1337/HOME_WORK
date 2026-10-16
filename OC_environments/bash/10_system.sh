#!/usr/bin/env bash
# Задача 10. Количество обычных файлов считается рекурсивно в /etc.
printf 'Ядро: %s\n' "$(uname -s)"
printf 'Свободно на /: %s\n' "$(df -h --output=avail / | awk 'NR==2{print $1}')"
printf 'Доступных обычных файлов в /etc (рекурсивно): %s\n' "$(find /etc -type f 2>/dev/null | wc -l)"
