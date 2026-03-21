# Build Flavors (dev / staging / production)

Useful when your app needs different API URLs, app names, or icons per
environment (e.g. KES Tracker pointing at a local dev backend vs the real
production Render/Supabase URL).

## 1. Define flavors in `android/app/build.gradle`
```groovy
android {
    flavorDimensions "environment"
    productFlavors {
        dev {
            dimension "environment"
            applicationIdSuffix ".dev"
            resValue "string", "app_name", "MyApp Dev"
        }
        production {
            dimension "environment"
            resValue "string", "app_name", "MyApp"
        }
    }
}
```

## 2. Pass environment-specific config at build time
```bash
flutter run --flavor dev --dart-define=API_URL=http://localhost:3000
flutter build appbundle --flavor production --dart-define=API_URL=https://api.myapp.com
```

## 3. Read it in Dart code
```dart
const apiUrl = String.fromEnvironment('API_URL', defaultValue: 'https://api.myapp.com');
```

This means the SAME codebase produces a dev build (pointing at your local
server, easy to tell apart with a different icon/name) and a completely
separate production build, without manually editing config files before
every build (which is easy to forget and accidentally ship dev config to
production).
