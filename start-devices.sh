#!/bin/bash

# Script para iniciar os dispositivos Flutter automaticamente
# Este script resolve o problema de "Device not found" no VS Code

echo "🚀 Iniciando dispositivos Flutter..."

# Função para verificar se um simulador iOS está rodando
check_ios_running() {
    xcrun simctl list devices | grep "8ED5F75C-61FD-491A-B607-4B1F95C9B053" | grep "Booted" > /dev/null
    return $?
}

# Função para verificar se o emulador Android está rodando
check_android_running() {
    adb devices | grep "emulator-5554" > /dev/null
    return $?
}

# Iniciar iOS Simulator se não estiver rodando
if check_ios_running; then
    echo "✅ iOS Simulator já está rodando"
else
    echo "📱 Iniciando iOS Simulator..."
    open -a Simulator
    xcrun simctl boot 8ED5F75C-61FD-491A-B607-4B1F95C9B053 2>&1 || true
    sleep 3
    echo "✅ iOS Simulator iniciado"
fi

# Iniciar Android Emulator se não estiver rodando
if check_android_running; then
    echo "✅ Android Emulator já está rodando"
else
    echo "🤖 Iniciando Android Emulator..."
    flutter emulators --launch Medium_Phone_API_36.1 > /dev/null 2>&1 &
    sleep 15
    echo "✅ Android Emulator iniciado"
fi

echo ""
echo "📋 Dispositivos disponíveis:"
flutter devices

echo ""
echo "✨ Pronto! Agora você pode usar F5 no VS Code"
