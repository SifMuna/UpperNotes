<p align="center"><img src="assets/images/icon.png" width="150"></p>
<h2 align="center"><b>UpperNotes</b></h2>
<h4 align="center">Encrypted, private note manager.</h4>

<p align="center">
<a href="https://www.gnu.org/licenses/gpl-3.0" alt="License: GPLv3"><img src="https://img.shields.io/badge/License-GPL%20v3-blue.svg?style=for-the-badge&logo=gnu"></a>
<a href="#" alt="Platform"><img src="https://img.shields.io/badge/platform-Android-3DDC84.svg?style=for-the-badge&logo=android"></a>
</p>

UpperNotes is a fork of [Safe Notes](https://safenotes.dev) — an offline, AES-256-encrypted note manager. Notes are stored locally on the device, encrypted with a passphrase you choose. The app makes no network requests.

## Why this fork?

The upstream app is solid, but a couple of things bothered me enough to fork:

- **Gboard shift-key crash.** On recent Gboard versions, pressing Shift inside a passphrase or no-suggestion field could kill the app. Fixed by pairing `enableSuggestions: false` and `autocorrect: false` with `enableIMEPersonalizedLearning: false` everywhere — the desync that triggered the crash can't happen anymore.
- **Forced periodic passphrase entry.** Upstream forces you to re-enter the passphrase every 5 biometric logins, with no way to disable it. UpperNotes adds **Settings → Biometric → Passphrase challenge**, where you can either allow biometrics indefinitely (the new default) or require the passphrase every N days (you pick N).
- **No passphrase strength gate.** Upstream rejects short or "weak" passphrases without explaining what makes them weak. UpperNotes only requires that the passphrase be non-empty — pick whatever you want.

Plus light cleanup: app rebrand, new icon, the in-app footer reads "Made with 🫀 somewhere", and the settings/sidebar no longer link to upstream-specific resources (Rate Us, FAQs, Help, Email). The Source Code link points here.

The encryption, storage format, and on-disk layout are unchanged from upstream, so backups exported from Safe Notes can be imported into UpperNotes and vice versa.

## Features (from upstream)

- AES-256 encrypted local storage
- Biometric authentication
- Android background-snapshot protection (`FLAG_SECURE`)
- Incognito keyboard (no IME learning, no suggestions)
- Brute-force lockout
- Inactivity auto-logout
- Encrypted local backup with import/export
- Light/dark theme (Arctic Nord palette)
- Grid and list views, optional colorful notes
- No telemetry, no network calls

> [!IMPORTANT]
> There is no passphrase recovery. Lose the passphrase, lose the notes.

> [!WARNING]
> Some security features can't be guaranteed on rooted devices.

## Installation

UpperNotes is not on Play Store or F-Droid. Build it yourself, or grab a release APK from [Releases](https://github.com/SifMuna/UpperNotes/releases) when one is published.

The Android `applicationId` is `com.uppernotes.app` (upstream is `com.trisven.safenotes`), so UpperNotes installs side-by-side with Safe Notes — they don't share storage.

## Building

Requires Flutter (tested against the current `stable` channel, 3.41.x), Android SDK 34+, and JDK 17.

```bash
flutter pub get
flutter build apk --debug      # debug APK
flutter build apk --release    # release APK (needs android/key.properties)
```

The Android toolchain pinned in this repo:

| Tool | Version |
|---|---|
| Gradle | 8.11.1 |
| Android Gradle Plugin | 8.9.1 |
| Kotlin | 2.1.0 |
| `compileSdk` | 36 |
| `minSdk` | 25 |
| NDK | 28.2.13676358 |

## License

Same as upstream: [GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0). See [LICENSE](LICENSE).

## Credits

All credit for the original app belongs to [Keshav Priyadarshi](https://github.com/keshav-space) and the [Safe Notes contributors](https://github.com/keshav-space/safenotes/graphs/contributors). UpperNotes is a small set of behavioral and branding patches on top of their work.
