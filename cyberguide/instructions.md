# CyberGuide - Instrukcja Obsługi i Budowania

CyberGuide to aplikacja mobilna stworzona we Flutterze, mająca na celu edukację osób starszych w zakresie cyberbezpieczeństwa. Aplikacja imituje styl Duolingo, oferując krótkie lekcje, animowaną maskotkę oraz system grywalizacji.

## Funkcje aplikacji
- **9 Lekcji:** Tematyka obejmuje silne hasła, phishing (SMS/Email), bezpieczeństwo sieci, zakupy online oraz ochronę prywatności.
- **Różne typy zadań:** Quizy jednokrotnego wyboru, zadania Prawda/Fałsz oraz symulacje rozmów (np. oszustwo "na wnuczka").
- **Dostępność:** Możliwość dostosowania wielkości tekstu, włączenia wysokiego kontrastu, lektora (TTS) oraz zmiany nawigacji z gestów na przyciski.
- **Grywalizacja:** Zbieranie punktów XP, utrzymywanie "streaków" (dni nauki pod rząd) oraz brak limitu żyć (nauka bez stresu).
- **Animacje:** Płynne przejścia typu "Magic Move" (Hero animations) oraz organicznie animowana maskotka.

## Wymagania systemowe
- Flutter SDK (wersja 3.10 lub nowsza)
- Android Studio / Xcode (do budowania odpowiednio na Androida/iOS)
- Java JDK 11+ (dla Androida)

## Instalacja i uruchomienie

### 1. Pobranie zależności
W folderze głównym projektu wykonaj:
```bash
flutter pub get
```

### 2. Uruchomienie w trybie debugowania
Podłącz urządzenie lub uruchom emulator i wykonaj:
```bash
flutter run
```

### 3. Budowanie pliku instalacyjnego (APK)
Możesz użyć gotowego skryptu:
```bash
./build.sh
```
Lub ręcznie:
```bash
flutter build apk --release
```
Gotowy plik APK znajdziesz w: `build/app/outputs/flutter-apk/app-release.apk`.

## Struktura projektu
- `lib/main.dart`: Punkt wejścia aplikacji i konfiguracja motywu.
- `lib/screens/`: Ekrany aplikacji (Onboarding, Mapa lekcji, Zadania, Ustawienia).
- `lib/providers/`: Zarządzanie stanem (ustawienia, postęp w grze).
- `lib/content/`: Treści edukacyjne lekcji w języku polskim.
- `lib/widgets/`: Komponenty wielokrotnego użytku, w tym animowana maskotka.
- `lib/models/`: Modele danych dla lekcji i pytań.

## Wskazówki dotyczące wdrażania (Store Ready)
1. **Ikona aplikacji:** Ikony zostały wygenerowane i znajdują się w folderach platformowych.
2. **Nazwa pakietu:** `com.cyberguide.senior`
3. **Lokalizacja:** Aplikacja jest w pełni zlokalizowana na język polski.
4. **Bezpieczeństwo:** Aplikacja nie wymaga backendu, wszystkie dane są przechowywane lokalnie na urządzeniu.
