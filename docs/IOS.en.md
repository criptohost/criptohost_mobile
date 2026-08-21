# iOS — fleet panel as an app (PWA); mining out of scope

## What works today: CriptoHost as an app on iPhone/iPad ✅

Every CriptoHost node (ESP32 board or PC running the CH Agent) serves the dashboard with PWA support. On the iPhone:

1. In **Safari**, open any node on your network:
   - board: `http://ch-8634.local` · PC: `http://ch-cpu-01.local:8091`
2. Tap **Share → Add to Home Screen**.
3. Done: CriptoHost icon on your home screen, opening **full-screen standalone** (no Safari chrome), with Home/Fleet/Config — full fleet control: live telemetry, change pool/wallet, restart miners, watch shares.

> `.local` resolves natively on iOS (Bonjour). Tip: add the most stable node in the house (a board that's always on).

On Android the same dashboard works in Chrome; "Add to home screen" creates a shortcut (full PWA install would require HTTPS, which LAN nodes don't have — a platform limitation, documented here so we don't promise what the browser blocks).

## Why the iPhone doesn't mine (out of scope) ❌

A recorded decision — the limit is Apple policy, not engineering:

1. **App Store bans mining**: the App Store Review Guidelines (§2.4.2) explicitly reject apps that mine cryptocurrency on device. Publishing isn't an option even if we wanted it.
2. **No binary sideloading**: iOS won't run arbitrary binaries outside signed apps. There is no "Termux for iOS" — iSH emulates x86 by interpretation (useless for hashing) and a-Shell can't run external executables.
3. **The browser can't sustain it**: WASM mining in Safari does ~1–3 MH/s and stops when the screen locks — no value, even educational, against the battery cost.

### Experimental loophole (lab use, at your own risk)

With an Apple Developer account you can compile the cpuminer core as a static library inside a SwiftUI app and install it **on your own device** via Xcode (personal signing: expires in 7 days on a free account, 1 year on a paid one; max 3 apps; no distribution). The A17/A18 has the same ARMv8 crypto extensions — roughly 50–100 MH/s… until thermal throttle. If the experiment ever feels worth it: new Xcode target + cpuminer-opt's `sha256d` as a lib + a minimal UI speaking the local `/api/status` contract.

**The project's official recommendation**: iPhone/iPad = fleet control panel (PWA above). Mining belongs to the ESP32s, PCs, servers and Android.
