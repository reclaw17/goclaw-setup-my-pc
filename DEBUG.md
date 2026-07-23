# DEBUG — полный разбор текущего состояния

Дата: 2026-07-23

## Что уже работает

1. Структура проекта на флешке
2. `подготовить.sh` скачивает Fabric + GoClaw Linux + модель
3. `старт.sh` доходит до реального бинарника GoClaw
4. Модель проверяется по SHA256
5. Skills / prompts / safety / admin-check на месте

## Ошибка с последнего скрина

```text
unsafe gateway auth configuration
gateway token is required when GOCLAW_HOST="0.0.0.0"
set GOCLAW_GATEWAY_TOKEN or GOCLAW_ALLOW_INSECURE_NO_AUTH=1
```

Причина:
- GoClaw Standard по умолчанию слушает `0.0.0.0`
- без токена это запрещено

Исправление в launcher:
- `GOCLAW_HOST=127.0.0.1`
- автогенерация `GOCLAW_GATEWAY_TOKEN` и `GOCLAW_ENCRYPTION_KEY` в `.env`

## Главная архитектурная недоделка

Мы взяли **GoClaw Standard** (server binary).

Он рассчитан на:
- PostgreSQL
- gateway token
- encryption key
- серверный/multi-tenant сценарий

А цель проекта:
- портативный агент с флешки
- минимум инфраструктуры
- offline fallback

### GoClaw Lite (Desktop)
- SQLite, без Postgres
- ближе к нашей цели
- **Linux пока официально не поддерживается**
- macOS installer есть, Windows zip упоминается, Linux — no

## Известные баги / дыры

| # | Проблема | Статус |
|---|----------|--------|
| 1 | Launcher был stub Phase 3 | Исправлено |
| 2 | Gateway auth / 0.0.0.0 | Исправлено в launcher |
| 3 | GOCLAW_MODE deprecated warning | Убрали GOCLAW_MODE |
| 4 | Нужен PostgreSQL для Standard | **Открыто** |
| 5 | GoClaw Windows binary отсутствует upstream | **Открыто** |
| 6 | GoClaw Lite нет для Linux | **Открыто** |
| 7 | Обвязки/skills не подключены в runtime goclaw config автоматически | Частично |
| 8 | Desktop/UX двойной клик .sh | Улучшено (Konsole) |
| 9 | Окно терминала не закрывалось | Исправлено |
| 10 | FETCH_BINARIES руками | Исправлено через подготовить.sh |

## Что будет после фикса auth

Следующая вероятная ошибка:
```text
postgres / DSN missing
```

Пока не будет:
- локального PostgreSQL, или
- Docker Compose с postgres, или
- перехода на runtime без Postgres

агент Standard не станет по-настоящему portable.

## Практические варианты дальше

### A. Быстрый (остаёмся на Standard)
1. Поставить PostgreSQL на машину / через Docker
2. Прописать `GOCLAW_POSTGRES_DSN` в `.env`
3. Запускать `bash старт.sh`

### B. Правильный long-term
1. Пересмотреть runtime: GoClaw Lite когда появится Linux
2. Или другой lightweight agent runtime + наши skills/prompts
3. Оставить Fabric offline path

## Что сделать пользователю прямо сейчас

1. Обновить с GitHub:
   - `launcher/start-linux.sh`
   - `.env.example`
   - `DEBUG.md`
2. Запустить:
```bash
bash старт.sh
```
3. Прислать следующий вывод, если снова ошибка
