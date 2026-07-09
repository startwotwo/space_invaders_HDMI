# Space Invaders HDMI — Zybo Z7-20

Reimplementação do clássico *Space Invaders* rodando **bare-metal** (sem sistema operacional) no processador ARM Cortex-A9 embutido no SoC Xilinx Zynq-7000, com saída de vídeo via **HDMI** em 640×480 a 60 FPS. Desenvolvido para a placa **Digilent Zybo Z7-20**, usando o fluxo Xilinx **Vivado** (hardware/Block Design) + **Vitis** (software embarcado).

Repositório original do projeto: https://github.com/startwotwo/space_invaders_HDMI

## Visão geral

O hardware é composto por um sistema de processamento (PS7) e um pipeline de vídeo montado no IP Integrator: **AXI VDMA** (lê o framebuffer da DDR), **Video Timing Controller** (gera a temporização 640×480@60Hz), conversor **AXI4-Stream → vídeo paralelo** e o IP **rgb2dvi** da Digilent, que serializa o sinal em TMDS diferencial para a saída HDMI física. A entrada do jogador é feita por 4 botões da placa, lidos via **AXI GPIO**.

O software, em C, roda inteiramente no Cortex-A9 e implementa a lógica completa do jogo — frota de invasores com 6 formações (incluindo um easter egg que desenha a palavra "MATÃO"), bunkers destrutíveis, disco voador bônus, pontuação, vidas, níveis progressivos e máquina de estados — desenhando cada quadro em um framebuffer na DDR que é varrido continuamente pelo VDMA (double buffering via *park mode*) e convertido em vídeo HDMI pelo hardware.

## Controles

| Botão | Função |
|---|---|
| BTN0 | Mover nave para a direita |
| BTN1 | Mover nave para a esquerda |
| BTN2 | Disparar / confirmar (início e reinício de partida) |
| BTN3 | Pausar / retomar |

## Hardware necessário

- Placa Digilent **Zybo Z7-20** (Zynq-7000, `xc7z020clg400-1`)
- Cabo Micro-USB (programação/alimentação/UART)
- Cabo HDMI + monitor compatível com 640×480@60Hz

## Ferramentas necessárias

- **Xilinx Vivado** 2025.2 (Block Design / IP Integrator)
- **Xilinx Vitis** Unified IDE 2025.2 (compilação do software bare-metal)
- **Digilent Board Files** (`vivado-boards`) — adiciona a Zybo Z7-20 ao Vivado
- **Digilent Vivado Library** — necessária para o IP `rgb2dvi`
- Cable drivers Xilinx/Digilent (JTAG/USB)

## Estrutura do repositório

| Arquivo / pasta | Finalidade |
|---|---|
| `space_invaders_HDMI.xpr` | Projeto Vivado |
| `script.tcl` | Recria o Block Design do zero |
| `.../constrs_1/new/hdmi.xdc` | Constraints de pinos (TMDS/HDMI) |
| `.../sources_1/bd/design_1/` | Fonte do Block Design |
| `design_1.pdf` | Exportação gráfica do Block Design |
| `workspace/` | Workspace do Vitis (plataforma + aplicação) |
| `workspace/app_component/src/main.c` | Código-fonte completo do jogo |
| `workspace/platform/hw/sdt/design_1_wrapper.bit` | Bitstream gerado |

## Como rodar (resumo)

1. Instale Vivado + Vitis 2025.2, os *board files* e a *IP library* da Digilent.
2. Abra `space_invaders_HDMI.xpr` no Vivado (ou rode `script.tcl` para recriar o projeto).
3. Gere o wrapper HDL e o bitstream (**Generate Bitstream**).
4. Exporte o hardware com bitstream incluído (**File → Export → Export Hardware**) para gerar o `.xsa`.
5. No Vitis, crie a Platform a partir do `.xsa` e o Application Component com `main.c`; compile.
6. Programe o FPGA (Vivado Hardware Manager) e execute o software (**Run As → Launch Hardware**) via Vitis.
7. Conecte o monitor via HDMI — o jogo inicia na tela de título; pressione BTN2 para jogar.

