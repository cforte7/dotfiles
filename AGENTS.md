# AGENTS.md

## Purpose

This repository provisions personal development environments and manages shell configuration with GNU Stow. Keep changes portable, minimal, and safe to apply repeatedly.

## Repository layout

- `install.sh`: top-level installer and OS dispatch
- `install/`: shared, macOS, and Linux provisioning
- `brew/Brewfile`: Homebrew dependencies
- `zsh/` and `tmux/`: files stowed into `$HOME`
- `tests/`: shell-based behavior and portability checks
- `archive/`: historical scripts; do not update unless explicitly requested

## Working rules

- Preserve macOS and Linux behavior unless a change is intentionally platform-specific.
- Keep provisioning scripts idempotent and quote shell variables.
- Never commit secrets, tokens, machine-specific paths, or generated local state.
- Do not hand-edit `zsh/.p10k.zsh` unless the request specifically concerns Powerlevel10k configuration.
- Treat `install.sh` and `stow.sh` as destructive to the current home directory; do not run them for routine verification.
- Add or update focused shell tests for behavior changes.
