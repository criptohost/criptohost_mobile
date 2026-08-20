# CriptoHost Mobile

**Celulares na frota CriptoHost — Android minerando via Termux, iOS como painel de controle (PWA). Sem lojas de aplicativos.**

Um produto [Cripto Host](https://cripto.host) · parte do ecossistema [criptohost_nerdos](https://github.com/criptohost/criptohost_nerdos) (ESP32) e [criptohost_cpuminer](https://github.com/criptohost/criptohost_cpuminer) (Windows/Linux/macOS).

---

## Android — nó minerador completo 🤖

Instale o [Termux via F-Droid](https://f-droid.org/packages/com.termux/) e rode:

```bash
curl -fsSL https://raw.githubusercontent.com/criptohost/criptohost_mobile/main/setup-termux.sh | bash
```

O script instala dependências, clona o `criptohost_cpuminer`, compila com as extensões crypto do ARMv8 e abre o mesmo menu dos PCs — wallet, pool (DGB default), dashboard web na porta 8091, mDNS. O celular aparece no Fleet ao lado das placas e servidores. Guia completo, desempenho e cuidados térmicos: [docs/ANDROID.md](docs/ANDROID.md).

## iOS — painel da frota como app 📱

Safari → abra qualquer nó da rede (`http://ch-8634.local`) → **Adicionar à Tela de Início**. Vira um app standalone com ícone CriptoHost: telemetria ao vivo, Fleet, Config e Restart de todos os nós.

Mineração em iOS está **fora de escopo por política da Apple** (App Store Guidelines §2.4.2 proíbem mineração on-device, e não há sideload de binários) — a justificativa completa e a brecha experimental via certificado de desenvolvedor estão em [docs/IOS.md](docs/IOS.md).

## Por que não é um fork

Diferente dos irmãos (forks de NerdMiner_v2 e cpuminer-opt), aqui não há upstream a forkar: o candidato existente ([wong-fi-hung/termux-miner](https://github.com/wong-fi-hung/termux-miner), citado como referência) é baseado no cpuminer-multi — núcleo mais antigo e sem licença declarada — e manter dois cores de mineração fragmentaria o ecossistema. Este repositório é a **camada mobile fina** sobre o `criptohost_cpuminer`: bootstrap, documentação e integrações de plataforma.

## Fleet em rede

Mesmo contrato de sempre: `_criptohost._tcp` via mDNS + `GET /api/status`. Onde o multicast do Android falhar, use peers estáticos (`ch/peers.conf` no criptohost_cpuminer — funciona também para servidores em datacenter).

## Licença e marca

Scripts e docs deste repo: [MIT](LICENSE). Os componentes que ele instala mantêm suas licenças (cpuminer-opt: GPL-2.0). Marca Cripto Host protegida — mesmo modelo do [BRANDING.md](https://github.com/criptohost/criptohost_nerdos/blob/main/BRANDING.md) do ecossistema.

---

*"Miner de um jeito fácil" — agora no bolso. Enquadramento honesto: hobby e educação; retorno esperado ~zero.*
