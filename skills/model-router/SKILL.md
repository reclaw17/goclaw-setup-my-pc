# model-router

**Status:** Production-ready  
**Last update:** 2026-07-22

## Purpose
Select the correct model **and** its corresponding wrapper (harness).

## Decision logic
1. If internet is available → use one of the cloud models (Grok 4.5 / Qwen 3.8 / Minimax M2.7) + matching wrapper.
2. If internet is unavailable → switch to local Qwen3.5-9B + `wrapper-qwen-local.md` via Fabric.
3. Always inform the user about the current mode and active model.

## Wrapper mapping
| Model              | Wrapper file                     |
|--------------------|----------------------------------|
| Grok 4.5           | prompts/wrappers/grok.md         |
| Qwen 3.8           | prompts/wrappers/qwen-cloud.md   |
| Minimax M2.7       | prompts/wrappers/minimax.md      |
| Qwen3.5-9B (local) | prompts/wrappers/qwen-local.md   |

All wrappers are combined with `prompts/system-common.md`.

## Rules
- Local model is **only** a fallback.
- When switching models, switch the wrapper at the same time.
- Never hide the current mode from the user.

## Integration
- Controls `fabric-offline`
- Works with all other skills
