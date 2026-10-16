#!/usr/bin/env bash
# Небольшие автоматические проверки всех 20 решений. Никакого sudo.
set -uo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
B="$ROOT/bash"
pass=0
fail=0
ok() { printf '[OK] %s\n' "$1"; ((pass+=1)); }
bad() { printf '[FAIL] %s\n' "$1"; ((fail+=1)); }
test_contains() {
  local label=$1 want=$2 actual=$3
  if [[ "$actual" == *"$want"* ]]; then ok "$label"; else bad "$label (не найдено: $want)"; fi
}
for file in "$B"/*.sh; do
  if ! bash -n "$file"; then bad "синтаксис $(basename "$file")"; fi
done

test_contains 01 'Пользователь:' "$("$B/01_hello.sh")"
test_contains 02 'OK' "$("$B/02_check.sh")"
test_contains 03 'shebang' "$(sh "$B/03_shebang.sh")"
perm=$("$B/04_perm.sh")
test_contains 04 '04_perm.sh' "$perm"
test_contains 05 'Последний: gamma' "$("$B/05_args.sh" alpha 'beta gamma' gamma)"
test_contains 06 'Иван, 30 лет, из Москвы' "$("$B/06_vars.sh")"
test_contains 07 'Код возврата последней команды (true): 0' "$("$B/07_status.sh")"
arith=$(printf '10\n3\n' | "$B/08_arithmetic.sh")
test_contains 08 'Остаток: 1' "$arith"
if command -v bc >/dev/null 2>&1; then test_contains 09 '2^10 = 1024' "$("$B/09_bc.sh")"; else printf '[SKIP] 09: bc не установлен\n'; fi
test_contains 10 'Ядро:' "$("$B/10_system.sh")"
test_contains 11 'Привет, Гость!' "$("$B/11_guest.sh")"
test_contains 12 'С export: secret' "$("$B/12_export.sh")"
test_contains 13 'После unset: не задана' "$("$B/13_readonly.sh" 2>/dev/null)"
if env -u CONFIG "$B/14_config.sh" >/dev/null 2>&1; then bad '14: незаданная CONFIG должна дать ошибку'; else test_contains 14 'CONFIG: example' "$(CONFIG=example "$B/14_config.sh")"; fi
test_contains 15 'git version' "$("$B/15_git.sh")"
test_contains 16 'Длина (символы): 3' "$(printf 'abc\n' | "$B/16_case.sh")"
test_contains 17 'Код ls /: 0' "$("$B/17_exit.sh" 2>/dev/null)"
test_contains 18 'Пользователь sample авторизован' "$(printf 'sample\ntestpassword\n' | "$B/18_login.sh")"
test_contains 19 'Введено: quick' "$(printf 'quick\n' | "$B/19_timeout.sh")"
test_contains 20 '2. two' "$(printf 'one two\n' | "$B/20_words.sh")"
printf '\nИтого: OK=%s, FAIL=%s\n' "$pass" "$fail"
(( fail == 0 ))
