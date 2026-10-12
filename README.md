# Practise App

Flutter application structured according to the team's Clean Architecture standards (`common/` + `features/`).

---

## 📁 Project Structure

### `lib/common/`
Shared modules, configurations, and core utilities used across all features:
- `config/`: Environment and application configurations
- `constants/`: Global constants
- `cubit/`: Shared state cubits
- `http/`: Network clients and HTTP interceptors
- `logger/`: Logging utilities
- `model/`: Global models and DTOs
- `permissions/`: App permission handling
- `storage/`: Local storage / preferences
- `system_ui/`: System overlay and status bar styling
- `theme/`: Theme definitions and color palettes
- `utils/`: Helpers and formatters
- `widgets/`: Reusable cross-feature UI widgets
- `wrapper/`: Root wrappers and guards

### `lib/features/`
Feature-specific modules (each containing `bloc`, `constants`, `model`, `resource`, `service`, `ui`, and `utils`):
- `splash/`: Initial launch screen
- `onboard/`: Welcome & onboarding flow

## Development

Run the app with an explicit environment:

```bash
flutter pub get
flutter run --dart-define=APP_ENV=development
flutter run --dart-define=APP_ENV=staging
flutter build ipa --dart-define=APP_ENV=production
```

`APP_ENV` defaults to `development`. The current Firebase project is selected
by `firebase_options.dart`; use separate Firebase projects and generated
options files for staging and production before releasing.

## Firebase Setup

1. Enable Google as a sign-in provider in Firebase Authentication.
2. Add the Android SHA-1/SHA-256 fingerprints and download the updated
	`google-services.json`.
3. Add the iOS URL scheme from `GoogleService-Info.plist` in Xcode and enable
	Push Notifications and Background Modes for Remote notifications.
4. Send a test FCM message from Firebase Console. The app requests permission,
	registers the device token, and handles foreground/background callbacks.

The dashboard restaurant feed uses a page-based repository and a visible
`Load more` control. Replace `RestaurantRepository.fetchPage` with the API or
Firestore query when the production data source is ready; keep the same
`RestaurantPage` contract so the UI pagination remains unchanged.

## Showcase Checklist

- Demonstrate onboarding, Google sign-in, profile editing, sign-out, and the
  persisted session.
- Demonstrate notification permission and an FCM foreground/background message.
- Demonstrate `Load more` on the dashboard and the loading state.
- Run `flutter analyze` and `flutter test` before pushing the branch.
