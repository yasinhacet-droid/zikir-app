# Zikir – Tasbih-Zähler (Flutter)

Android-App (iPhone als Web-App) zum Zählen von Zikir. Ohne Login, alle Daten bleiben auf dem Gerät.

## Funktionen
- 9 vordefinierte Zikir mit arabischem Text, Umschrift, deutscher Bedeutung und Zielanzahl
- Antippen zum Zählen, goldener Fortschrittsring, Fortschrittsbalken in der Übersicht
- Wischen zwischen Zikir, „Weiter“-Button nach Erreichen des Ziels (z. B. 33/33/34)
- −1 (Vertipper korrigieren), Reset einzeln und gesamt (mit Rückfrage)
- Vibration beim Tippen (stärker bei Zielerreichung), ein-/ausschaltbar
- Zählerstände bleiben nach App-Neustart erhalten

## Projektstruktur
```
lib/
  main.dart                    App-Start, Theme, Sprache
  models/zikir.dart            Datenmodell
  data/zikir_data.dart         Liste der Zikir  <- hier neue Zikir eintragen
  services/storage_service.dart  Speicherung (shared_preferences)
  state/zikir_controller.dart  Logik: zählen, reset, vibration
  theme/app_theme.dart         Farben (Grün/Gold)
  screens/home_screen.dart     Übersicht
  screens/counter_screen.dart  Zähl-Ansicht
  widgets/                     wiederverwendbare Bausteine
test/                          Tests der Logik
assets/icon/                   App-Icon
ci/debug.keystore              fester Signatur-Schlüssel (für Updates ohne Datenverlust)
.github/workflows/             Cloud-Build (APK + optional Web-App)
```

## Neuen Zikir hinzufügen
In `lib/data/zikir_data.dart` einen Eintrag anhängen, mit neuer, eindeutiger `id`. Die `id` bestehender Einträge nicht ändern, sonst ist der gespeicherte Zählerstand weg.

## Bauen
Der Build läuft über GitHub Actions. Lokal wird kein Flutter gebraucht.
Jeder Push auf `main` erzeugt eine neue APK unter „Releases“.

Lokal (falls Flutter installiert ist):
```
flutter create . --project-name zikir_app --org de.zikir --platforms android,ios,web
flutter pub get
flutter run
```

## Hinweis Signatur
`ci/debug.keystore` ist ein Debug-Schlüssel und für die private Nutzung ausreichend. Für eine Veröffentlichung im Play Store einen eigenen Release-Schlüssel erstellen und als GitHub-Secret hinterlegen.
