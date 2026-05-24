# Security Policy

UpperNotes is a small personal fork of [Safe Notes](https://github.com/keshav-space/safenotes). The encryption and on-disk storage internals are unchanged from upstream; UpperNotes only adds a handful of behavioral and branding patches.

## Reporting a Vulnerability

Please report security issues **privately** — do not open a public issue containing exploit details.

- Preferred: [open a private security advisory](https://github.com/SifMuna/UpperNotes/security/advisories/new) on this repository.

This is a personal project maintained on a best-effort basis, so there is no guaranteed response window, but reports will be reviewed as soon as practical.

## Scope

- If the issue also affects upstream **Safe Notes**, please report it to the [upstream project](https://github.com/keshav-space/safenotes) as well — most of the security-relevant code originates there.
- By design, UpperNotes has **no passphrase recovery**: if you lose your passphrase, your notes cannot be decrypted. This is intended behavior, not a vulnerability.

## Disclosure

Please allow a reasonable window to investigate and ship a fix before any public disclosure.
