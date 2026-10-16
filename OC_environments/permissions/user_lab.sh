#!/usr/bin/env bash
# Лабораторная: реальные пользователи и владельцы в тестовой Linux VM.
set -euo pipefail
if (( EUID != 0 )); then
  printf 'Запустите в учебной VM: sudo bash permissions/user_lab.sh\n' >&2
  exit 1
fi
LAB_DIR=/srv/linux-homework-users
for user in hw_alice hw_bob hw_carol; do
  if ! id "$user" >/dev/null 2>&1; then
    useradd --create-home --shell /bin/bash "$user"
  fi
done
install -d -o root -g root -m 1777 "$LAB_DIR"
# Повторный запуск безопасно пересоздаёт только три лабораторных файла.
rm -f -- "$LAB_DIR/alice.txt" "$LAB_DIR/bob.txt" "$LAB_DIR/carol.txt"
# Каждый файл действительно первоначально создаётся от имени своего пользователя.
for spec in 'hw_alice alice.txt' 'hw_bob bob.txt' 'hw_carol carol.txt'; do
  read -r user filename <<< "$spec"
  runuser -u "$user" -- bash -c 'umask 077; printf "Файл создан пользователем %s\n" "$1" > "$2"' _ "$user" "$LAB_DIR/$filename"
done
# После создания намеренно меняем владельцев на других пользователей.
chown hw_bob:hw_bob "$LAB_DIR/alice.txt"
chown hw_carol:hw_carol "$LAB_DIR/bob.txt"
chown hw_alice:hw_alice "$LAB_DIR/carol.txt"
chmod 600 "$LAB_DIR/alice.txt"
chmod 640 "$LAB_DIR/bob.txt"
chmod 754 "$LAB_DIR/carol.txt"
printf '\nСозданные пользователи:\n'
for user in hw_alice hw_bob hw_carol; do id "$user"; done
printf '\nИтоговые права и владельцы:\n'
ls -la "$LAB_DIR"
stat -c '%n | %U:%G | %a | %A' "$LAB_DIR"/*.txt
printf '\nПробуем читать от имени hw_alice:\n'
for name in alice.txt bob.txt carol.txt; do
  if runuser -u hw_alice -- cat "$LAB_DIR/$name"; then
    printf 'Чтение %s: разрешено\n' "$name"
  else
    printf 'Чтение %s: запрещено\n' "$name"
  fi
done
