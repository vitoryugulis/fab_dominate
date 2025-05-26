# Information about the project

Fab 13 Dominate

## Requirements
- Flutter SDK 3.27.1
- Dart SDK ^3.6.0

## Run local
```bash
flutter pub get
flutter run -d chrome --dart-define=FLAVOR=dev
```
## Build Dev
```bash
flutter build web --release --base-href="/" --output=build/webdev --dart-define=FLAVOR=dev
```

## Build Prod
```bash
flutter build web --base-href="/fab_dominate/" --release --dart-define=FLAVOR=prod --dart-define=API_KEY=API_KEY
```

## Release to GHPages:
Run the Deploy and Build Github Action