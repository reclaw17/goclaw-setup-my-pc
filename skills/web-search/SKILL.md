# web-search

**Source idea:** Human20 `workshop-perplex-search` (catalog)  
**Status:** Production-ready  
**Last update:** 2026-07-24

## Purpose
Use **internet search** only when local USB docs cannot answer.

## Priority
1. `local-docs` (`docs/**` on USB)  
2. This skill (if network works)  
3. Admit uncertainty — do not invent package names or UCI options  

## When to use
- Local docs miss the topic  
- Need current package versions / CVE / upstream changelog  
- User explicitly asks to search the web  

## When NOT to use
- Offline mode  
- Answer already found in `docs/`  
- Dangerous “how to attack / bypass law” requests — refuse  

## Workflow
1. State that local docs were checked first (or skip only if user forbids).  
2. Search with a **narrow** query (OpenWrt UCI, pacman package, Microsoft doc title).  
3. Prefer official domains: openwrt.org, wiki.archlinux.org, wiki.cachyos.org, learn.microsoft.com, adguard.com.  
4. Quote minimal commands; run them only after `safety-confirm` / `admin-check` when elevating.  
5. If sources conflict — say so.  

## Integration
- After findings that belong on the stick, suggest saving a short note under `docs/custom/`  
- Never put API keys into search queries  
