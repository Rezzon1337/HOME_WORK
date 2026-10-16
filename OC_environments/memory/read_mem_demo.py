#!/usr/bin/env python3
"""Безопасная лабораторная демонстрация /proc/<pid>/mem на 2 дочерних процессах.
Читаем только заранее известные буферы с тестовым текстом, без чужих данных.
"""
from __future__ import annotations
import ctypes
import os
import subprocess
import sys
import time

PAYLOAD = b"LINUX_HW_MEMORY_SAMPLE"


def child() -> None:
    buf = ctypes.create_string_buffer(PAYLOAD)
    addr = ctypes.addressof(buf)
    print(f"{os.getpid()} {addr}", flush=True)
    time.sleep(10)
    # Ссылка сохраняет буфер доступным до завершения дочернего процесса.
    assert buf.raw.startswith(PAYLOAD)


def parent() -> int:
    processes = []
    try:
        for index in (1, 2):
            proc = subprocess.Popen(
                [sys.executable, __file__, "--child"],
                stdout=subprocess.PIPE,
                text=True,
                env=dict(os.environ),
            )
            processes.append(proc)
            assert proc.stdout is not None
            info = proc.stdout.readline().strip()
            if not info:
                print(f"Процесс {index} не сообщил PID", file=sys.stderr)
                continue
            pid_s, addr_s = info.split()
            pid, addr = int(pid_s), int(addr_s)
            print(f"Процесс {index}: PID={pid}; виртуальный адрес тестового буфера=0x{addr:x}")
            with open(f"/proc/{pid}/maps", encoding="utf-8") as f:
                first = f.readline().strip()
                print(f"  /proc/{pid}/maps (первая строка): {first}")
            try:
                fd = os.open(f"/proc/{pid}/mem", os.O_RDONLY)
                try:
                    data = os.pread(fd, len(PAYLOAD), addr)
                    print(f"  /proc/{pid}/mem (только свой тестовый буфер): {data!r}")
                    assert data == PAYLOAD, "Данные буфера не совпали"
                finally:
                    os.close(fd)
            except (OSError, PermissionError) as exc:
                print(f"  /proc/{pid}/mem: доступ ограничен ({exc}); это может быть нормой")
        return 0
    finally:
        for proc in processes:
            if proc.poll() is None:
                proc.terminate()
        for proc in processes:
            try:
                proc.wait(timeout=2)
            except subprocess.TimeoutExpired:
                proc.kill()
                proc.wait()


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "--child":
        child()
    else:
        if not os.path.isdir("/proc"):
            sys.exit("Этот пример выполняется только в Linux с /proc")
        sys.exit(parent())
