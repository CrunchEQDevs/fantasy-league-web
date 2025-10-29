#!/bin/bash

# Script para fazer hot reload em todos os dispositivos rodando Flutter

echo "🔥 Fazendo hot reload em todos os dispositivos..."

# Encontra todos os processos do Flutter
FLUTTER_PIDS=$(ps aux | grep "flutter run" | grep -v grep | awk '{print $2}')

if [ -z "$FLUTTER_PIDS" ]; then
    echo "❌ Nenhum Flutter rodando encontrado"
    exit 1
fi

# Envia 'r' para cada processo do Flutter
for PID in $FLUTTER_PIDS; do
    echo "r" > /proc/$PID/fd/0 2>/dev/null || true
done

echo "✅ Hot reload enviado para todos os dispositivos!"
