#!/bin/bash

# Script para rodar o app em todos os dispositivos com hot reload automático
# Execute este script em um terminal separado

cd "$(dirname "$0")"

echo "🚀 Iniciando app em todos os dispositivos..."
echo ""
echo "Hot reload ativado! Salve qualquer arquivo para ver as mudanças."
echo "Comandos disponíveis:"
echo "  r - Hot reload manual"
echo "  R - Hot restart"
echo "  q - Sair"
echo ""

flutter run -d all
