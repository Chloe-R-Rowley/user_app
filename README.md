# user_app

A cross-platform Flutter application for managing and viewing user information. Built with Flutter, it features state management using BLoC, REST API integration for user data, and custom UI components for a modern user experience. The app supports Android, iOS, and web platforms.

## Requirements

- **Flutter SDK**: [Install Flutter](https://docs.flutter.dev/get-started/install) (stable channel recommended)
- **Dart SDK**: Included with Flutter (requires Dart >=3.8.1)
- **Supported Platforms**: Android, iOS, Web, Windows, macOS, Linux

## Setup

1. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd user_app
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

## Running the App

Run on your desired platform using the following commands:

- **Android:**
  ```sh
  flutter run -d android
  ```
- **iOS:** (macOS only)
  ```sh
  flutter run -d ios
  ```
- **Web:**
  ```sh
  flutter run -d chrome
  ```

## Building Release Versions

- **Android APK:**
  ```sh
  flutter build apk
  ```
- **iOS:**
  ```sh
  flutter build ios
  ```
- **Web:**
  ```sh
  flutter build web
  ```

## Troubleshooting

- Ensure your Flutter SDK is up to date:
  ```sh
  flutter upgrade
  ```
- Check your environment:
  ```sh
  flutter doctor
  ```
- For platform-specific issues, refer to the [Flutter documentation](https://docs.flutter.dev/).
