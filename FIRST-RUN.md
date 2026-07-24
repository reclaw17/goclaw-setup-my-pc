# First run (Phase A + B)

## Goal

Get a working GoClaw Lite agent from USB with **cloud Grok** as fast as possible.  
Local Fabric + model auto-download = **Phase D** (not required for first success).

## Steps (Linux / CachyOS / Arch)

```bash
git clone https://github.com/reclaw17/goclaw-setup-my-pc.git
cd goclaw-setup-my-pc
bash prepare.sh                 # language: 1=EN default, 2=RU
cp -n .env.example .env
nano .env                       # set XAI_API_KEY=...
bash start.sh
```

In the GoClaw window:

1. **Provider** — xAI (Grok), URL `https://api.x.ai/v1`, paste key  
2. **Model** — pick a Grok model  
3. **Agent** — finish wizard  

Full field tables: [docs/PROVIDERS.md](docs/PROVIDERS.md)

## What prepare.sh does

- Downloads `apps/GoClaw-Lite-x86_64.AppImage` from  
  [goclaw-lite-cachyos **v0.2.0-cachyos**](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos)
- Does **not** download the multi‑GB local model yet

## Update later

```bash
bash update.sh
# or
./apps/GoClaw-Lite-x86_64.AppImage --update
```

## Offline path (later)

See plan Phase D: Fabric binary + `models/*.gguf` + provider `http://127.0.0.1:8080/v1`.

---

## Russian

1. `bash prepare.sh` — скачает AppImage  
2. `.env` → `XAI_API_KEY`  
3. `bash start.sh`  
4. В мастере: Grok + ключ + модель  

Пресеты: [docs/PROVIDERS.md](docs/PROVIDERS.md)
