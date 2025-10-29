#!/bin/bash

# Script para rodar os 3 emuladores no terminal integrado do VSCode
# Isso garante hot reload automático sem conflitos

echo "🚀 Iniciando Fantasy League nos 3 emuladores..."
echo ""

# Função para verificar se o device está conectado
wait_for_device() {
    local device_id=$1
    local device_name=$2
    echo "⏳ Aguardando $device_name conectar..."

    while ! flutter devices | grep -q "$device_id"; do
        sleep 2
    done

    echo "✅ $device_name conectado!"
}

# Verifica se os emuladores estão conectados
echo "📱 Verificando dispositivos..."
echo ""

wait_for_device "chrome" "Chrome"
wait_for_device "8ED5F75C-61FD-491A-B607-4B1F95C9B053" "iPhone 16e"
wait_for_device "emulator-5554" "Android"

echo ""
echo "✨ Todos os dispositivos conectados!"
echo ""
echo "🔥 Iniciando apps (vai abrir 3 janelas de terminal)..."
echo ""

# Abre 3 terminais separados para cada dispositivo
osascript <<EOF
tell application "Terminal"
    -- Chrome
    do script "cd '$PWD' && echo '🌐 Iniciando Chrome...' && flutter run -d chrome"

    -- Aguarda 3 segundos
    delay 3

    -- iOS
    do script "cd '$PWD' && echo '📱 Iniciando iOS...' && flutter run -d 8ED5F75C-61FD-491A-B607-4B1F95C9B053"

    -- Aguarda 3 segundos
    delay 3

    -- Android
    do script "cd '$PWD' && echo '🤖 Iniciando Android...' && flutter run -d emulator-5554"
end tell
EOF

echo "✅ Todos os apps foram iniciados!"
echo ""
echo "💡 DICA: Quando alterar o código e salvar, os 3 vão atualizar automaticamente!"
echo ""
echo "Para parar: pressione 'q' em cada terminal"
