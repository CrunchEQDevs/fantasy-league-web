#!/bin/bash

# Script para rodar apenas no Chrome

cd "$(dirname "$0")"

echo "🌐 Iniciando app no Chrome..."
echo ""

flutter run -d chrome
