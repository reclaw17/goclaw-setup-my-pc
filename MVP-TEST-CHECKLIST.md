# MVP Hardware Test Checklist

Use this checklist on real hardware (target: 8 GB VRAM + 16 GB RAM).

## 1. Boot & Launcher
- [ ] Linux launcher starts without errors
- [ ] Windows launcher starts without errors
- [ ] Correct USB root is detected

## 2. First-run model download
- [ ] When model is missing, user sees clear message
- [ ] Download starts from pinned source
- [ ] Progress is visible
- [ ] Checksum is verified
- [ ] Model is saved to models/
- [ ] Second launch does not re-download

## 3. Online mode
- [ ] Cloud model is selected by default
- [ ] Correct wrapper is loaded
- [ ] Agent answers simple questions

## 4. Offline mode
- [ ] Internet disabled → agent switches to local model
- [ ] User is informed about offline mode
- [ ] Local wrapper is used
- [ ] Fabric starts successfully
- [ ] Agent can answer from local docs

## 5. Safety
- [ ] Dangerous command is shown before execution
- [ ] Agent waits for explicit confirmation
- [ ] "No" stops the action

## 6. OpenWrt flow
- [ ] Agent offers backup first
- [ ] Backup command is correct
- [ ] Confirmation is required before changes

## 7. PC setup flow
- [ ] Detects Linux vs Windows correctly
- [ ] Suggests safe package commands
- [ ] Uses safety-confirm

## 8. Failure paths
- [ ] Broken model download → clear error, no crash
- [ ] Missing binary → clear error
- [ ] Fabric fails to start → clear error

## Pass criteria
All critical items above must pass without unsafe behaviour.
