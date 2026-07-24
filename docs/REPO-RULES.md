# GitHub repo rules (multilingual)

**Applies to:** `goclaw-setup-my-pc` (main agent) and, by convention, `goclaw-lite-cachyos` (packaging).

## 1. Language policy

| Layer | Language | Why |
|-------|----------|-----|
| **GitHub UI default / README first section** | **English** | Search, forks, upstream contact, CI logs |
| **Beginner entry** (how to run on USB) | **Russian + English** | Owner and primary users |
| **Code, scripts logic, CI YAML, tags** | **English** identifiers | Stable tooling |
| **User-facing script prompts** | EN default, RU optional (`LANG_UI=ru`) | Same pattern as Lite repo |
| **Commit messages** | **English** (short imperative) | History searchable |
| **Issues / Discussions** | EN or RU both OK | Answer in the language of the question |

**Rule of thumb:** *English first in docs structure; Russian never blocked; no Russian-only critical paths without an English twin or bilingual block.*

## 2. README shape

```markdown
# Title (English)

Short EN pitch

## English
### Quick start
...

## Russian
### Быстрый старт
...
```

- Badge row and **Latest release** links stay language-neutral.
- Do not maintain two full README files (`README.ru.md`) unless content diverges a lot; prefer one bilingual README.

## 3. File and folder names

| Kind | Convention |
|------|------------|
| Source of truth scripts | English: `scripts/fetch-goclaw-appimage.sh` |
| Beginner wrappers (optional) | Russian OK at **repo root only**: `старт.sh`, `подготовить.sh` — must call English scripts inside |
| Docs | English filenames: `USB-STRUCTURE.md`, `docs/REPO-RULES.md` |
| Skills | English folder names: `skills/openwrt/` |

**Do not** invent parallel trees `en/` and `ru/` for the same files.

## 4. Scripts UX

- Default UI language: **English** (`LANG_UI=en`).
- Russian: `LANG_UI=ru` or menu option `2`.
- Messages that users see may be bilingual in one line when short (`Continue? / Продолжить?`).

## 5. Releases

- Tag names: English/semver style (`v0.2.0-cachyos`, not Cyrillic).
- Release title: English primary; RU sentence allowed in body.
- Asset names: ASCII only (`GoClaw-Lite-x86_64.AppImage`).

## 6. Secrets and safety

- Never commit `.env`, API keys, tokens.
- `.env.example` in English comments; RU comments optional below.
- Public positioning: **unofficial** community project; upstream GoClaw is separate.

## 7. Two-repo layout

| Repo | Language note |
|------|----------------|
| `goclaw-lite-cachyos` | Packaging factory — EN-first README already |
| `goclaw-setup-my-pc` | USB agent — EN-first + RU beginner path |

Cross-links always use full HTTPS URLs (language-neutral).

## 8. When adding content

Checklist:

1. English section exists (or file is pure code).
2. Russian beginner path not broken (`старт.sh` / README RU block).
3. No new Russian-only script without English implementation underneath.
4. Commit message in English.

## 9. Cleanup policy

Legacy Russian-only root names may remain as **wrappers** until a major version; new work goes English-first under `scripts/` and `docs/`.
