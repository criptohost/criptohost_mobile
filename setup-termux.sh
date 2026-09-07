#!/data/data/com.termux/files/usr/bin/bash
# CriptoHost Mobile — bootstrap completo no Termux (Android, sem loja)
#
# Uso (dentro do Termux):
#   curl -fsSL https://raw.githubusercontent.com/criptohost/criptohost_mobile/main/setup-termux.sh | bash
#
# O que faz: instala dependências, clona o criptohost_cpuminer, compila com
# as extensões crypto do ARMv8 e abre o menu de mineração.
set -euo pipefail

case "${PREFIX:-}" in *com.termux*) : ;; *)
  echo "⚠ Este script roda dentro do Termux (instale via F-Droid: https://f-droid.org/packages/com.termux/)"
  exit 1
esac

echo "==> Dependências…"
pkg update -y
# cpuminer-opt só compila em 64 bits (x86_64+SSE2 ou aarch64+NEON). Termux 32 bits (armv7l/armv8l) —
# comum em TV box — falha com "use of undeclared identifier 'v128u32_t'" em simd-utils/intrlv.h.
ARCH=$(uname -m)
case "$ARCH" in
  aarch64|x86_64) : ;;
  *)
    ABIS=$(getprop ro.product.cpu.abilist 2>/dev/null || true)
    echo "✗ Termux em 32 bits ($ARCH): o minerador precisa de 64 bits (aarch64)."
    case "$ABIS" in
      *arm64-v8a*) echo "  O aparelho é 64 bits ($ABIS), mas o Termux instalado é a versão 32 bits."
                   echo "  Desinstale o Termux e instale o APK arm64-v8a (F-Droid escolhe o certo; no GitHub pegue termux-app_*_arm64-v8a.apk).";;
      *)           echo "  O Android deste aparelho é só 32 bits (abilist: ${ABIS:-?}). Não há como rodar o minerador nele.";;
    esac
    exit 1;;
esac

pkg install -y git clang make autoconf automake libtool binutils \
               openssl libcurl libjansson zlib python termux-api > /dev/null || \
pkg install -y git clang make autoconf automake libtool binutils \
               openssl libcurl libjansson zlib python

echo "==> Código…"
cd "$HOME"
if [ -d criptohost_cpuminer ]; then
  git -C criptohost_cpuminer pull --ff-only
else
  git clone --depth 1 https://github.com/criptohost/criptohost_cpuminer.git
fi
cd criptohost_cpuminer

echo "==> Build (aarch64 + crypto)…"
bash ./ch/build-android.sh

echo
echo "✅ Pronto. Antes de minerar, segure a CPU acordada:"
echo "     termux-wake-lock"
echo "   E inicie:"
echo "     cd ~/criptohost_cpuminer && ./ch/mine.sh"
echo
echo "   Dashboard (opção [2] do menu): http://<ip-do-celular>:8091"
echo "   ⚠ Use na tomada — mineração esquenta o aparelho. Comece com poucas threads."
