#!/bin/bash

# Скрипт зеркального резервного копирования домашней директории
SOURCE="$HOME/"
DEST="/tmp/backup"
LOG_TAG="backup_home"

# Выполняем rsync: -a (архив), -v (подробно, для лога), --delete (удаляем лишнее в DEST)
# Исключаем скрытые директории (как в задании 1) - по желанию, в задании 2 это не оговорено
# Если нужно полное зеркало без исключений, уберите --exclude
rsync -av --delete "$SOURCE" "$DEST" 2>&1 | logger -t "$LOG_TAG" -p user.info

# Проверяем код возврата rsync
if [ ${PIPESTATUS[0]} -eq 0 ]; then
    logger -t "$LOG_TAG" -p user.info "Резервное копирование УСПЕШНО завершено"
else
    logger -t "$LOG_TAG" -p user.err "Ошибка при резервном копировании (код ${PIPESTATUS[0]})"
fi