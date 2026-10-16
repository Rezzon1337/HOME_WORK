# HOMEWORK

Репозиторий домашних работ.

| Каталог | Содержание |
|---|---|
| [OC_environments](OC_environments/) | GNU/Linux, Debian/VirtualBox, Bash (20 заданий), файлы, права доступа, пользователи, процессы и память; готовые скрипты и тесты |
| [network](network/) | Место для будущих домашних работ по сетям (задания пока не предоставлены) |

## Запуск тестов Linux

```bash
bash OC_environments/tests/test_bash.sh
bash OC_environments/filesystem/file_ops_demo.sh
bash OC_environments/memory/collect_memory.sh
```

Для задания с `bc` на Debian: `sudo apt install bc`. При запуске работы с пользователями нужны root-права, поэтому используйте отдельную учебную VM.

### Происхождение материалов

Скрипты и тексты созданы как решения исходного домашнего задания. Реальные журналы проверок приведены в [OC_environments/evidence](OC_environments/evidence/), а условия проверки — в [RESULTS.md](OC_environments/RESULTS.md). Иллюстрации терминала в [evidence/examples](OC_environments/evidence/examples/) созданы генератором изображений; **не** являются скриншотами с компьютера владельца. Пароли и приватные файлы с доступами не публикуются.
