# Android — full miner via Termux (no app store)

Your Android phone becomes a **real CriptoHost fleet node**: it mines SHA-256d with the ARMv8 crypto extensions (same fast path as Apple Silicon), serves the dashboard on port 8091 and shows up on the Fleet next to boards and PCs.

> The Play Store bans mining apps — which is why the path is **Termux**, a Linux terminal for Android distributed outside the store. No root required.

## Install (5 minutes)

1. Install **Termux from F-Droid** (https://f-droid.org/packages/com.termux/) or the APK from Termux's GitHub releases. *The Play Store build is outdated and won't work.*
2. Open Termux and run:

```bash
curl -fsSL https://raw.githubusercontent.com/criptohost/criptohost_mobile/main/setup-termux.sh | bash
```

3. Mine:

```bash
termux-wake-lock        # keeps Android from suspending the CPU
cd ~/criptohost_cpuminer && ./ch/mine.sh
```

The menu is the same as on PCs: wallet, pool (DGB hmpool default), worker, threads — and option **[2]** starts the web dashboard + mDNS.

## Performance and care

| Device (estimate) | sha256d |
|---|---|
| Flagship (SD 8 Gen / Tensor) | 30–80 MH/s (drops with thermal throttle) |
| Mid-range | 10–30 MH/s |

- **Stay plugged in.** Mining drains batteries fast, and charge cycles under heat degrade them.
- **Start with half the threads** (`[6]` in the menu). The SoC heats up in minutes and Android drops the clock — fewer threads often sustains more.
- `termux-wake-lock` avoids Doze; some vendors (Xiaomi/Samsung) still kill processes — disable battery optimization for Termux in Settings.
- Project framing: **educational** — expected return is ~zero (see the ecosystem README).

## Fleet on the same network

- **The phone on other dashboards**: the agent announces `_criptohost._tcp` via mDNS. Android sometimes blocks multicast (vendor-dependent); if the phone doesn't appear on other nodes' Fleet by itself, add it by IP in any PC's `ch/peers.conf` (see `ch/peers.conf.example` in criptohost_cpuminer).
- **Other nodes on the phone's dashboard**: open `http://localhost:8091/fleet.html` on the phone (or from any machine: `http://<phone-ip>:8091`). If mDNS discovery fails on Android, create `~/criptohost_cpuminer/ch/peers.conf` with your nodes' IPs — the Fleet polls them directly.
