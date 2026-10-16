#!/usr/bin/env bash
# Задание по презентации "Работа с файлами": реальные примеры.
# Все изменения исключительно в безопасном временном каталоге.
set -euo pipefail
DEMO=$(mktemp -d -t linux-hw-files.XXXXXXXX)
trap 'rm -rf -- "$DEMO"' EXIT
cd "$DEMO"
log() { printf '\n### %s\n' "$*"; }
log "pwd"; pwd
log "mkdir -m 750 private"; mkdir -m 750 private
log "mkdir -p dir1/dir2/dir3"; mkdir -p dir1/dir2/dir3
log "mkdir dirA dirB"; mkdir dirA dirB
log "ls -F"; ls -F
log "ls -l"; ls -l
log "cd dirA; pwd; cd .."; cd dirA; pwd; cd ..
log "touch file1.txt file2.txt"; touch file1.txt file2.txt
log "cat > docs.txt (создание текста)"; cat > docs.txt <<'EOF'
Linux and UNIX
Red Hat Linux
cat
az
get put write
$1.00
EOF
log "cat docs.txt"; cat docs.txt
log "more docs.txt (интерактивная команда; пример: more docs.txt, выход q)"
log "cp docs.txt copied.txt"; cp docs.txt copied.txt
log "cp docs.txt dirA/"; cp docs.txt dirA/
log "cp -r dirA dir_copy"; cp -r dirA dir_copy
log "mv copied.txt renamed.txt"; mv copied.txt renamed.txt
log "mv renamed.txt dirB/"; mv renamed.txt dirB/
log "mv dir_copy renamed_dir"; mv dir_copy renamed_dir
log "cat > people.txt"; printf '1 Ivan 578 Moscow\n2 Peter 435 NewYork\n3 Sasha 734 Orel\n' > people.txt
log "cut -c 1-8 people.txt"; cut -c 1-8 people.txt
log "cut -d ' ' -f 2 people.txt"; cut -d ' ' -f 2 people.txt
log "grep -i linux docs.txt"; grep -i linux docs.txt
log "grep -ci 'Red Hat Linux' docs.txt"; grep -ci 'Red Hat Linux' docs.txt
log "grep -E '(get|put|print|write)' docs.txt"; grep -E '(get|put|print|write)' docs.txt
log "grep '^a.*z$' docs.txt"; grep '^a.*z$' docs.txt
log "grep -E '^[aA]$' docs.txt"; grep -E '^[aA]$' docs.txt || true
log "grep '\$1\.00' docs.txt"; grep '\$1\.00' docs.txt
log "find . -name '*.txt' -type f"; find . -name '*.txt' -type f
log "find . -type d"; find . -type d
log "find . -type f -maxdepth 1"; find . -maxdepth 1 -type f
log "find . -mtime -3 -type f"; find . -mtime -3 -type f
log "find . -user $(id -un) -type f"; find . -user "$(id -un)" -type f
log "find . -group $(id -gn) -type f"; find . -group "$(id -gn)" -type f
log "find . -name '*.txt' -exec wc -l {} \;"; find . -name '*.txt' -exec wc -l '{}' \;
log "find . -type f -size +500c"; head -c 1100 /dev/zero > large.dat; find . -type f -size +500c
log "find . -type f -atime +3"; touch -a -d '5 days ago' file1.txt; find . -type f -atime +3
log "rm file1.txt file2.txt"; rm file1.txt file2.txt
log "rm -i (демонстрация с подтверждением): printf 'n' | rm -i dirB/renamed.txt"; printf 'n\n' | rm -i dirB/renamed.txt; test -e dirB/renamed.txt
log "rm -v dirB/renamed.txt"; rm -v dirB/renamed.txt
log "rmdir пустого каталога"; rmdir dirB
log "rm -r renamed_dir"; rm -r renamed_dir
log "rmdir -p dir1/dir2/dir3"; rmdir -p dir1/dir2/dir3
log "ls -la"; ls -la
printf '\nЗавершено: все изменения находились в %s (каталог будет удалён).\n' "$DEMO" 
