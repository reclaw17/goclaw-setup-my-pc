# First-run logic (production)

## Goal
Make the agent usable on a clean USB without shipping multi-gigabyte files in git.

## Sequence on first launch

1. Detect OS (Linux / Windows)
2. Check internet availability
3. Check presence of required binaries (`goclaw`, `fabric`)
4. Check presence of model file `models/qwen3.5-9b-q4_k_m.gguf`
5. If model is missing **and** internet is available:
   - Show clear message to the user (size + time estimate)
   - Download from pinned URL in `SOURCES.md`
   - Verify SHA256
   - Save to `models/`
6. If model is missing **and** no internet:
   - Inform the user that offline first-run requires the model to be pre-placed
7. Start Fabric (if offline mode needed)
8. Start goclaw with correct prompts + skills + active wrapper

## User-facing messages (examples)

**Model missing + internet available:**
```
Локальная модель не найдена.
Сейчас скачаю Qwen3.5-9B (≈5 ГБ). Это нужно только один раз.
Продолжить? (да / нет)
```

**Download finished:**
```
Модель успешно загружена и проверена.
Переключаюсь в offline-режим.
```

**No internet + no model:**
```
Нет интернета и локальная модель отсутствует.
Положите файл models/qwen3.5-9b-q4_k_m.gguf на флешку и запустите снова.
```

## Quality requirements
- Progress indication during download
- Checksum verification is mandatory
- Never overwrite an existing valid model without confirmation
- All paths relative to USB root
