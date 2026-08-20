# iOS — painel da frota como app (PWA); mineração fora de escopo

## O que funciona hoje: CriptoHost como app no iPhone/iPad ✅

Todo nó CriptoHost (placa ESP32 ou PC com CH Agent) serve o dashboard com suporte a PWA. No iPhone:

1. Abra no **Safari** o endereço de qualquer nó da sua rede:
   - placa: `http://ch-8634.local` · PC: `http://ch-cpu-01.local:8091`
2. Toque em **Compartilhar → Adicionar à Tela de Início**.
3. Pronto: ícone CriptoHost na home, abre em **tela cheia standalone** (sem barra do Safari), com Home/Fleet/Config — controle completo da frota: ver telemetria ao vivo, trocar pool/wallet, reiniciar miners, acompanhar shares.

> O `.local` resolve nativamente no iOS (Bonjour). Dica: adicione o nó mais estável da casa (uma placa que fica sempre ligada).

No Android o mesmo dashboard funciona no Chrome; o "Adicionar à tela inicial" cria um atalho (a instalação PWA completa exigiria HTTPS, que não existe em nós de LAN — limitação de plataforma, documentada aqui para não prometer o que o navegador bloqueia).

## Por que o iPhone não minera (fora de escopo) ❌

Decisão registrada — a limitação é de política da Apple, não técnica:

1. **App Store proibida para mineração**: as App Store Review Guidelines (§2.4.2) vetam explicitamente apps que minerem criptomoeda no dispositivo. Publicar não é opção nem se quiséssemos.
2. **Sem sideload de binários**: iOS não executa binários arbitrários fora de apps assinados. Não existe "Termux para iOS" — o iSH emula x86 por interpretação (inútil para hash) e o a-Shell não roda executáveis externos.
3. **Navegador não sustenta**: mineração em WASM no Safari rende ~1–3 MH/s e para quando a tela apaga — sem valor até educacional frente ao custo de bateria.

### Brecha experimental (laboratório, por sua conta)

Com uma conta Apple Developer é possível compilar o núcleo do cpuminer como biblioteca estática dentro de um app SwiftUI e instalar **no próprio aparelho** via Xcode (assinatura pessoal: expira em 7 dias com conta gratuita, 1 ano com conta paga; máx. 3 apps; sem distribuição). O A17/A18 tem as mesmas extensões crypto ARMv8 — renderia na casa de 50–100 MH/s… até o thermal throttle. Se um dia valer o experimento, o caminho é: novo target Xcode + `sha256d` do cpuminer-opt como lib + UI mínima chamando o contrato `/api/status` local.

**Recomendação oficial do projeto**: iPhone/iPad = painel de controle da frota (PWA acima). Mineração fica nos ESP32, PCs, servidores e Android.
