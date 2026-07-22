# model-router

## Description
Automatically choose between cloud models and local Fabric model.

## Logic
- Internet available → use cloud models (Grok / Qwen / Minimax)
- No internet → start / use local Fabric model and inform the user

## Rules
- Always tell the user which mode is currently active (online / offline).
- Local model is only a fallback.
