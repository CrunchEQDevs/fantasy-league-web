#!/bin/bash

# Script para rodar apenas no Android

cd "$(dirname "$0")"

echo "🤖 Iniciando app no Android..."
echo ""

flutter run -d emulator-5554
