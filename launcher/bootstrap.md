# Bootstrap strategy (production)

## 1. Binaries (goclaw + Fabric)

**Approach:** Download official / forked release binaries on first run or via a setup script.

- goclaw: take latest release from official `nextlevelbuilder/goclaw` (or a controlled fork)
- Fabric: take latest release from `tetherto/qvac-fabric-llm.cpp` (or fork)

The launcher / setup script downloads the correct platform binary into `goclaw/` and `fabric/` folders on the USB.

This keeps the git repository light and always up-to-date with releases.

## 2. Model file (Qwen3.5-9B Q4_K_M)

**Approach:** Auto-download on first launch (inspired by QVAC examples).

When the agent detects that the model file is missing:

1. Inform the user
2. Download the GGUF from a reliable Hugging Face source into `models/`
3. Verify size / basic integrity
4. Continue in offline mode

Example pattern (from QVAC style):

```bash
mkdir -p models
wget -O models/qwen3.5-9b-q4_k_m.gguf \
  "https://huggingface.co/.../qwen3.5-9b-q4_k_m.gguf"
```

The exact URL will be fixed after choosing the precise quantized file.

## Benefits

- Git repo stays small
- USB can be prepared with just the launcher + config
- First run downloads what is needed
- Easy to update binaries and model later
