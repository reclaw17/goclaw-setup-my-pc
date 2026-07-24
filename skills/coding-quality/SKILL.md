# coding-quality

**Sources:** Human20 `workshop-shaw-coding-standard` + `superpowers` (catalog)  
**Status:** Production-ready  
**Last update:** 2026-07-24

## Purpose
Generate **small, correct, verifiable** commands and code for a non-developer user.

## Shaw-style rules (adapted)
1. **Goal first** — one sentence: what success looks like.  
2. **Minimal path** — fewest steps; no drive-by refactors.  
3. **Surgical change** — only what is needed (one UCI section, one pacman line).  
4. **Prove before done** — say how to verify (`ping`, `uci show`, `systemctl status`).  
5. **No false “готово”** — if not run/verified, say so.  

## Superpowers-style habits
- Break work into short steps the user can approve.  
- Prefer reversible actions.  
- Separate “explanation” from “commands to copy”.  

## Output format
1. Short plan  
2. Commands in a fenced block  
3. Expected result / how to check  
4. Rollback if something breaks  

## Integration
Always with `safety-confirm`; PC elevation with `admin-check`.
