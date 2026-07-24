# GitHub repo rules (multilingual)

**EN-first.** Russian is supported inside scripts and in README, not as the primary structure.

## 1. Languages

| Layer | Policy |
|-------|--------|
| README / docs structure | **English section first**, then Russian |
| File and folder names | **English only** for new files (`prepare.sh`, `scripts/`, `docs/`) |
| Root RU names (`старт.sh`, …) | **Legacy wrappers only** → call English scripts |
| Script UI | Menu **Language / Язык** — default **1) English** |
| Commit messages | **English** |
| **Issues** | **English preferred** for title + first message (so search works). Russian body OK if you also add a short EN summary. Labels in English. |

## 2. Canonical commands

```bash
bash prepare.sh    # not only подготовить.sh
bash start.sh
bash update.sh
```

Language without menu:

```bash
LANG_UI=en bash prepare.sh
LANG_UI=ru bash prepare.sh
```

## 3. Releases

- Tags/assets: ASCII only (`v0.2.0-cachyos`, `GoClaw-Lite-x86_64.AppImage`)
- Release title: English; RU allowed in notes

## 4. Secrets

Never commit `.env`. Example file comments in English.

## 5. Checklist for new files

1. English filename  
2. English-first docs  
3. If interactive — `source scripts/lib-lang.sh` + `pick_lang`  
4. Issue text: EN title  
