#!/bin/bash

# Skrypt do budowania aplikacji CyberGuide

echo "Rozpoczynam budowanie aplikacji CyberGuide..."

# Sprawdzenie czy flutter jest zainstalowany
if ! command -v flutter &> /dev/null
then
    echo "BŁĄD: Flutter nie jest zainstalowany lub nie ma go w PATH."
    exit 1
fi

# Pobranie zależności
echo "Pobieram zależności..."
flutter pub get

# Budowanie APK (debug)
echo "Buduję plik APK (debug)..."
flutter build apk --debug

if [ $? -eq 0 ]; then
    echo "SUKCES: Plik APK został wygenerowany w: build/app/outputs/flutter-apk/app-debug.apk"
else
    echo "BŁĄD: Budowanie APK nie powiodło się."
    exit 1
fi
