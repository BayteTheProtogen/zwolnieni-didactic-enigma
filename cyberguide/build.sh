#!/bin/bash

# Skrypt do budowania aplikacji CyberGuide (Android i iOS) dla Firebase App Distribution

echo "Rozpoczynam budowanie aplikacji CyberGuide..."

# Sprawdzenie czy flutter jest zainstalowany
if ! command -v flutter &> /dev/null
then
    echo "BŁĄD: Flutter nie jest zainstalowany lub nie ma go w PATH."
    exit 1
fi

# Pobranie zależności
echo "Pobieram zależności..."
flutter clean
flutter pub get

# 1. Budowanie Android (APK)
echo "Buduję plik APK (release)..."
flutter build apk --release

if [ $? -eq 0 ]; then
    echo "SUKCES: Plik APK został wygenerowany w: build/app/outputs/flutter-apk/app-release.apk"
else
    echo "BŁĄD: Budowanie APK nie powiodło się."
    exit 1
fi

# 2. Budowanie iOS (IPA)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Buduję aplikację na iOS (IPA)..."

    # Próba zbudowania IPA.
    # UWAGA: Wymaga skonfigurowanego certyfikatu i profilu w Xcode.
    # Jeśli budowanie się nie powiedzie z powodu braku profilu, użyj: flutter build ipa --no-codesign
    flutter build ipa --release

    if [ $? -eq 0 ]; then
        echo "SUKCES: Plik IPA został wygenerowany w folderze build/ios/ipa/"
        echo "Wskazówka: Możesz teraz przesłać Runner.ipa do Firebase App Distribution."
    else
        echo "BŁĄD: Budowanie iOS/IPA nie powiodło się. Upewnij się, że masz skonfigurowane podpisywanie (signing) w Xcode."
        echo "Próbuję zbudować archiwum bez podpisywania jako fallback..."
        flutter build ipa --release --no-codesign
        if [ $? -eq 0 ]; then
            echo "SUKCES: Archiwum bez podpisu wygenerowane. Do dystrybucji wymagane jest podpisanie w Xcode."
        else
            exit 1
        fi
    fi
else
    echo "INFORMACJA: Pomijam budowanie iOS (wymagany system macOS)."
fi

echo "Gotowe! Pliki są gotowe do wgrania na Firebase App Distribution."
