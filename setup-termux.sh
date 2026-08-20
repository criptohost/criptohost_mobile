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
