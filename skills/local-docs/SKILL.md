# local-docs

**Source:** Adapted from chip-docs-local (evgyur / Human20 archive)  
**Status:** Production-ready  
**Last update:** 2026-07-22

## Purpose
Provide fast, reliable, offline access to documentation stored on the USB flash drive. This skill is the primary knowledge source for the agent.

## When to use (priority order)
1. Any question about OpenWrt, CachyOS, Arch Linux, Windows 11, AdGuard, Amnezia, networking, VPN, drivers, system configuration.
2. Before using any internet search.
3. When the user adds or asks about files in `docs/custom/`.

## Directory structure (expected on USB)
```
docs/
├── openwrt/
├── cachyos-arch/
├── windows11/
├── adguard/
├── amnezia/
├── custom/          ← user can freely add new .md files here
├── FILELIST.md      ← optional index
└── state.json       ← optional metadata
```

## Workflow
1. Determine the most relevant folder based on the user question.
2. Search Markdown files inside that folder (and `custom/` if needed).
3. Prefer exact matches and official-looking content.
4. Extract only the relevant sections.
5. Answer using **only** the information found in the local files.
6. If nothing useful is found — clearly say:  
   «В локальной документации этого нет. Могу поискать в интернете (если есть сеть).»

## Strict Rules
- Local documentation always has higher priority than internet.
- Never invent commands, package names or procedures that are not present in the docs.
- When quoting, keep the answer short and actionable.
- Support the user adding new documents to `docs/custom/` without any special setup.
- If FILELIST.md or state.json exists — use them for faster navigation.

## Integration with other components
- Used by almost every other skill as the first knowledge source.
- Works in both online and offline modes.
- The model (brain) must call this skill before searching the web.

## Quality notes
This skill is deliberately kept simple and robust.  
It does not try to implement a full vector database.  
Simple filesystem + Markdown search is enough for our portable use-case and maximizes reliability on a USB drive.
