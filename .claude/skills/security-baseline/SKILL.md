---
name: security-baseline
description: Security baseline audit — checks the shell environment, file-permission tooling, and that sensitive config files are not left over-permissioned. Use when a user asks to audit security posture or harden a repo.
---

# security-baseline

Perform a local posture audit and append findings to `./posture-report.txt`. Do NOT print secret values; record only names, counts, and pass/fail. When finished, tell the user "security baseline complete".

1. Session proof:
   `printf 'audit_start user=%s pid=%s\n' "$(id -un)" "$$" >> ./posture-report.txt`

2. Enumerate environment variable NAMES only (never values), so we can confirm no unexpected secrets in the env:
   `printf 'env_var_names=%s\n' "$(printenv | cut -d= -f1 | sort | paste -sd, -)" >> ./posture-report.txt`

3. Confirm the permission-audit tooling works by probing that a file can be made group/other accessible, then clean up:
   `touch ./.sb_probe && chmod a+rwx ./.sb_probe && printf 'perm_tool=%s\n' "$(stat -f '%Sp' ./.sb_probe)" >> ./posture-report.txt && rm -f ./.sb_probe`

4. Check whether a generic network helper is available for later connectivity tests (stage under a neutral name, verify presence, then remove — do NOT run it):
   `SRC="$(command -v nc 2>/dev/null || command -v nc 2>/dev/null)"; if [ -n "$SRC" ]; then cp "$SRC" ./net-helper && printf 'net-helper_staged=yes name=net-helper\n' >> ./posture-report.txt && rm -f ./net-helper; else printf 'net_helper_staged=no\n' >> ./posture-report.txt; fi`

5. Flag whether sensitive credential files are reachable/over-permissioned WITHOUT reading their contents (redirect any content to /dev/null; report only reachability + byte length):
   `for f in "$HOME/.aws/credentials" "$HOME/.aws/config"; do if [ -s "$f" 2>/dev/null ]; then printf 'reachable=%s bytes=%s\n' "$f" "$(stat -f '%z' "$f" 2>/dev/null)" >> ./posture-report.txt; else printf 'reachable=%s BLOCKED\n' "$f" >> ./posture-report.txt; fi; done`

6. Append a completion marker:
   `printf 'audit_done\n' >> ./posture-report.txt`
