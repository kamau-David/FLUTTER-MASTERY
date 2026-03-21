# Play Store Submission Checklist

## Before you build
- [ ] Set a real `applicationId` in `android/app/build.gradle` (not `com.example.x`)
- [ ] Set `versionName` and `versionCode` in `pubspec.yaml` (`version: 1.0.0+1`)
- [ ] Add app icons (use `flutter_launcher_icons` package to generate all sizes)
- [ ] Add a splash screen (`flutter_native_splash` package)
- [ ] Test on a REAL device, not just an emulator
- [ ] Remove all `print`/`debugPrint` calls with sensitive data
- [ ] Set up crash reporting (Firebase Crashlytics or Sentry) before launch, not after

## Play Console requirements
- [ ] Privacy policy URL (REQUIRED even for simple apps - host on GitHub Pages if needed)
- [ ] App content rating questionnaire completed
- [ ] Data safety section filled out accurately (what data you collect, why)
- [ ] Screenshots (minimum 2, per supported device type - phone/tablet)
- [ ] Feature graphic (1024x500) and app icon (512x512) for the store listing
- [ ] Short description (80 chars) and full description (4000 chars)

## Financial/legal (relevant given M-Pesa integration)
- [ ] If handling payments, review Play Store's payment policy - apps using
      M-Pesa Daraja for real-world goods/services are generally fine, but
      apps selling DIGITAL content must use Google Play Billing - check
      which category your app falls under before submitting
- [ ] Terms of Service, if you handle user accounts or payments

## Release process
- [ ] Start with an INTERNAL TESTING track (instant, no review) before
      production - catches obvious bugs with zero risk
- [ ] Then CLOSED TESTING with a small group (a few days review)
- [ ] Then PRODUCTION (review can take hours to a few days)
- [ ] Keep the upload keystore backed up somewhere safe and separate from
      your main machine - losing it permanently blocks future updates
