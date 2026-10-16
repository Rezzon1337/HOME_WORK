#!/usr/bin/env bash
# Сбор только системных и собственных учебных данных без чтения чужой памяти.
set -euo pipefail
printf '=== Параметры окружения ===\n'
uname -a
printf '\n=== /proc/iomem ===\n'
cat /proc/iomem
printf '\n=== /proc/meminfo ===\n'
cat /proc/meminfo
printf '\n=== pgrep bash ===\n'
pgrep -a bash || true
printf '\n=== /proc/self/maps (фрагмент карты собственного процесса) ===\n'
head -n 15 /proc/self/maps
printf '\n=== Проверка существования /proc/self/mem ===\n'
ls -l /proc/self/mem
printf '\n=== Два безопасных учебных процесса: maps и mem ===\n'
python3 "$(dirname "$0")/read_mem_demo.py"
