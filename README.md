# Information about the project

Fab 13 Dominate

## run local
```bash
flutter pub get
flutter run -d chrome --dart-define=FLAVOR=dev
```

## Build Dev
```bash
flutter run -d chrome --dart-define=FLAVOR=dev
```

## Build Prod
```bash
flutter build web --base-href="/liga_commoner_13dominate/" --release --dart-define=FLAVOR=dev
```