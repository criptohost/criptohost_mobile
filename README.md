<div align="center">

# 📱 CriptoHost Mobile

**Celulares na frota CriptoHost — Android minerando via Termux, iOS como painel de controle. Sem lojas de aplicativos.**

🇧🇷 Português · [🇺🇸 English](README.en.md)

[![license](https://img.shields.io/badge/license-MIT-blue)](LICENSE)
[![core](https://img.shields.io/badge/core-criptohost__cpuminer-8b5cf6)](https://github.com/criptohost/criptohost_cpuminer)

*Um produto [Cripto Host](https://cripto.host) — "Miner de um jeito fácil"*

</div>

---

## 🧭 O que é isso?

A camada mobile do ecossistema CriptoHost: coloca o **Android para minerar SHA-256d de verdade** (via [Termux](https://f-droid.org/packages/com.termux/), fora da Play Store) e transforma o **iPhone/iPad em painel de controle da frota** (PWA, direto do Safari). O núcleo de mineração é o [criptohost_cpuminer](https://github.com/criptohost/criptohost_cpuminer) — este repo é o bootstrap e a documentação de plataforma.

> ⚠️ **Enquadramento honesto**: hobby e educação. Um moto g(60)s faz ~47 MH/s (e cai com o throttle térmico); um ASIC faz 200 TH/s. Minere na tomada, pelo aprendizado — o retorno esperado é ~zero.

## ✨ O que ele faz

- 🤖 **Android como nó minerador completo** — compila com as extensões crypto do ARMv8 (mesmo caminho rápido do Apple Silicon), mesmo menu CLI dos PCs, dashboard na porta 8091
- 📲 **Sem loja, sem root** — a Play Store proíbe mineração; o caminho é o Termux via F-Droid
- 🍎 **iOS como painel** — qualquer nó da rede vira app pelo "Adicionar à Tela de Início" (mineração em iOS é vetada pela Apple — [entenda](docs/IOS.md))
- 🕸️ **Mesma frota** — o celular aparece no Fleet ao lado de placas, Macs e servidores (mDNS + peers estáticos)
- 🌡️ **Consciente da térmica** — orientações de threads, wake-lock e bateria no [guia Android](docs/ANDROID.md)

## 🖼️ Telas

Capturas reais de um motorola moto g(60)s minerando a ~47 MH/s via Termux.

| | Desktop | Mobile |
|---|---|---|
| **Home** | ![Home](docs/screenshots/android-home-desktop.png) | <img src="docs/screenshots/android-home-mobile.png" width="260"> |
| **Fleet** | ![Fleet](docs/screenshots/android-fleet-desktop.png) | <img src="docs/screenshots/android-fleet-mobile.png" width="260"> |
| **Config** | ![Config](docs/screenshots/android-config-desktop.png) | <img src="docs/screenshots/android-config-mobile.png" width="260"> |

## 🚀 Comece em 5 minutos

### 🤖 Android (minerador)

1. Instale o **Termux pelo [F-Droid](https://f-droid.org/packages/com.termux/)** (a versão da Play Store não funciona). Precisa de **Android 64 bits** (arm64-v8a): celulares dos últimos anos são; TV boxes muitas vezes rodam Android 32 bits mesmo com chip 64 bits; nesse caso o script compila o motor alternativo (cpuminer-multi), que mina mais devagar (~1–3 MH/s por core).
2. No Termux:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/criptohost/criptohost_mobile/main/setup-termux.sh | bash
   ```
3. Minere:
   ```bash
   termux-wake-lock
   cd ~/criptohost_cpuminer && ./ch/mine.sh
   ```
4. Menu **[2]** = dashboard em `http://<ip-do-celular>:8091`. 🎉

Monero/Salvium (RandomX) no celular? Só em Android 64 bits com 3 GB+: `pkg install cmake libuv` e `cd ~/criptohost_cpuminer && ./ch/build-xmrig.sh`, depois escolha um perfil `xmr-*`/`sal-*` no menu. Esquenta mais que SHA-256d: na tomada, poucas threads.

Guia completo (desempenho por aparelho, bateria, Doze): [docs/ANDROID.md](docs/ANDROID.md).

### 🍎 iOS (painel da frota)

1. Safari → abra qualquer nó da rede (`http://ch-8634.local` ou `http://<ip>:8091`).
2. Compartilhar → **Adicionar à Tela de Início**.
3. Ícone CriptoHost na home, app standalone de tela cheia. Por que o iPhone não minera: [docs/IOS.md](docs/IOS.md).

## 🕸️ A frota (e os irmãos do ecossistema)

| Repositório | O que minera | Hashrate típico |
|---|---|---|
| [criptohost_nerdos](https://github.com/criptohost/criptohost_nerdos) | ESP32 (DevKit V1, S3, T-Display) | ~350 kH/s |
| [criptohost_cpuminer](https://github.com/criptohost/criptohost_cpuminer) | Windows, Linux e macOS (CPU) | 20–165 MH/s |
| **criptohost_mobile** (este) | Android via Termux (iOS = painel) | ~47 MH/s |

O multicast do Android costuma bloquear a descoberta mDNS — a solução é a **lista de peers da frota**: edite na tela Fleet de **qualquer** nó (um `ip[:porta] [token]` por linha; o token dá acesso a nós expostos na internet) e todos os outros — o celular incluído — sincronizam sozinhos em ~1 min.

## ❓ Perguntas honestas

**Por que não tem app na loja?** Play Store e App Store proíbem apps de mineração — e a nossa filosofia é local e sem intermediários mesmo. **Estraga a bateria?** Minerar no calor degrada bateria, sim — use na tomada e com poucas threads. **iPhone nunca vai minerar?** Sem jailbreak/dev-cert, não — é política da Apple, não limitação nossa ([detalhes](docs/IOS.md)).

## 🧑‍💻 Para desenvolvedores

Por que este repo **não é um fork** (avaliamos o [termux-miner](https://github.com/wong-fi-hung/termux-miner) e mantivemos núcleo único no cpuminer): ver seção no [docs/ANDROID.md](docs/ANDROID.md) e o histórico de decisões nos commits. O build Android real vive em [`ch/build-android.sh` do cpuminer](https://github.com/criptohost/criptohost_cpuminer/blob/main/ch/build-android.sh).

## 📜 Licença, marca e créditos

- **Scripts e docs deste repo**: [MIT](LICENSE). Componentes instalados mantêm suas licenças (cpuminer-opt: GPL-2.0).
- **Marca**: código livre, marca protegida — [BRANDING.md](https://github.com/criptohost/criptohost_nerdos/blob/main/BRANDING.md) do ecossistema.

## 💬 Contato

Dúvidas, ideias ou parceria: **fale@cripto.host** · Issues e PRs são bem-vindos.

---

<div align="center">

*Small power. Big learning.* 💜

</div>
