# Android — minerador completo via Termux (sem loja)

O celular Android vira um **nó de frota CriptoHost de verdade**: minera SHA-256d com as extensões crypto do ARMv8 (mesmo caminho rápido do Apple Silicon), serve o dashboard na porta 8091 e aparece no Fleet junto com placas e PCs.

> A Play Store proíbe apps de mineração — por isso o caminho é o **Termux**, um terminal Linux para Android distribuído fora da loja. Nenhum root necessário.

## Instalação (5 minutos)

1. Instale o **Termux pelo F-Droid** (https://f-droid.org/packages/com.termux/) ou pelo APK das releases no GitHub do Termux. *A versão da Play Store é antiga e não funciona.*
2. Abra o Termux e rode:

```bash
curl -fsSL https://raw.githubusercontent.com/criptohost/criptohost_mobile/main/setup-termux.sh | bash
```

3. Minere:

```bash
termux-wake-lock        # impede o Android de suspender a CPU
cd ~/criptohost_cpuminer && ./ch/mine.sh
```

O menu é o mesmo dos PCs: wallet, pool (DGB hmpool default), worker, threads, e a opção **[2]** sobe o dashboard web + mDNS.

## Desempenho e cuidados

| Aparelho (estimativa) | sha256d |
|---|---|
| Flagship (SD 8 Gen / Tensor) | 30–80 MH/s (cai com throttle térmico) |
| Intermediário | 10–30 MH/s |

- **Use na tomada.** Mineração drena bateria rápido e ciclos de carga sob calor degradam a bateria.
- **Comece com metade das threads** (`[6]` no menu). O SoC esquenta em minutos e o Android reduz o clock — menos threads às vezes rende mais sustentado.
- `termux-wake-lock` evita o Doze; ainda assim alguns fabricantes (Xiaomi/Samsung) matam processos — desative a otimização de bateria para o Termux nas configurações.
- Enquadramento do projeto: **educacional** — o retorno esperado é ~zero (ver README do ecossistema).

## Fleet na mesma rede

- **O celular nos outros dashboards**: o agent anuncia `_criptohost._tcp` via mDNS. O Android às vezes bloqueia multicast (depende do fabricante); se o celular não aparecer sozinho no Fleet dos outros nós, adicione-o por IP no `ch/peers.conf` de qualquer PC (veja `ch/peers.conf.example` no criptohost_cpuminer).
- **Os outros no dashboard do celular**: acesse `http://localhost:8091/fleet.html` no próprio aparelho (ou de qualquer máquina: `http://<ip-do-celular>:8091`). Se a descoberta mDNS falhar no Android, crie `~/criptohost_cpuminer/ch/peers.conf` com os IPs dos seus nós — o Fleet os consulta diretamente.
