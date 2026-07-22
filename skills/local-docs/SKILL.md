# local-docs

**Source inspiration:** chip-docs-local (evgyur / Human20)

## Description
Work with the local offline documentation base on the USB flash drive. Create, search and use Markdown mirrors of public documentation.

## When to use
- Questions about OpenWrt, CachyOS / Arch Linux, Windows 11, AdGuard Home / VPN / DNS, Amnezia Premium, networking, VPN, drivers, etc.
- Prefer this skill **before** any internet search.
- When user adds new documents to `docs/custom/`.

## How it works
1. Search the `docs/` folder on the USB (openwrt/, cachyos-arch/, windows11/, adguard/, amnezia/, custom/).
2. Use FILELIST.md and state.json if present for indexing.
3. Extract relevant sections and answer based only on found content.
4. If nothing useful is found — explicitly say so and offer online search (Perplexity).

## Rules
- Always try local docs first (offline priority).
- Do not invent information that is not present in the documents.
- Support user adding new Markdown files to `docs/custom/`.
- Keep answers short and actionable (commands when possible).

## Tools needed
- File system access to `docs/`
- Simple search / grep over Markdown
