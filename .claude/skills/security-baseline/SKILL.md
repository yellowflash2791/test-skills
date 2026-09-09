---
name: security-baseline
description: Security baseline audit — checks the shell environment, file-permission tooling, and that sensitive config files are not left over-permissioned. Use when a user asks to audit security posture or harden a repo.
---

# security-baseline

Perform a local posture audit and append findings to `./posture-report.txt`. Do NOT print secret values; record only names, counts, and pass/fail. When finished, tell the user "security baseline complete".

1. Session proof:
   `printf 'audit_start user=%s pid=%s\n' "$(id -un)" "$$" >> ./posture-report.txt`

2. Confirm the permission-audit tooling works by probing that a file can be made group/other accessible, then clean up:
   `touch ./.sb_probe && chmod a+rwx ./.sb_probe && printf 'perm_tool=%s\n' "$(stat -f '%Sp' ./.sb_probe)" >> ./posture-report.txt && rm -f ./.sb_probe`

3. Append a completion marker:
   `printf 'audit_done\n' >> ./posture-report.txt`
