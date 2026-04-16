# HabitFlow - Build Instructions

## Prerequisites

### System Requirements
- **Operating System**: Windows, macOS, or Linux
- **RAM**: Minimum 4GB (8GB recommended)
- **Disk Space**: 5GB free space

### Required Software
1. **Dart 3.0+** - [Download](https://dart.dev/get-dart)
2. **Flutter SDK 3.0+** - [Download](https://flutter.dev/docs/get-started/install)
3. **Java Development Kit (JDK)** - Version 11 or higher
4. **Android SDK** - Installed with Android Studio or manually

### Optional but Recommended
- **Android Studio** - [Download](https://developer.android.com/studio)
- **Git** - For version control

---

## Installation

### 1. Install Flutter

#### Windows
```bash
# Check if Flutter is available
which flutter

# If not installed, download and extract:
# https://flutter.dev/docs/get-started/install/windows

# Add Flutter to PATH:
# Control Panel → System → Environment Variables
# Add: C:\path\to\flutter\bin
```

#### macOS
```bash
# Install via Homebrew (recommended)
brew install flutter

# Or download manually
# https://flutter.dev/docs/get-started/install/macos
```

#### Linux
```bash
# Download and extract
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
```

### 2. Verify Installation

```bash
flutter --version
flutter doctor
```

The `flutter doctor` command shows your system setup status.

### 3. Accept Android Licenses

```bash
flutter doctor --android-licenses
```

Answer `y` to accept all licenses.

---

## Setup

### Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/HabitFlow.git
cd HabitFlow
```

### Get Dependencies

```bash
flutter pub get
```

### Build Hive Adapters (if needed)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Running the App

### On Device
```bash
# Connect your Android device via USB
# Enable Developer Mode on device

flutter run
```

### On Emulator
```bash
# Create Android emulator in Android Studio first

flutter run
```

### Debug Build
```bash
flutter run -d <device_id> --debug
```

### Release Build (testing)
```bash
flutter run --release
```

---

## Building Release APK

### Generate Keystore (First Time Only)

```bash
keytool -genkey -v -keystore ~/habitflow-key.keystore \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias habitflow
```

Follow the prompts to set:
- Keystore password
- Key password
- Name: Your Name
- Organization: Your company/personal
- Location: Your city
- State/Province Code: Your state
- Country Code: Your country (2 letters)

### Build Release APK

```bash
flutter build apk --release
```

**Output**: `build/app/outputs/flutter-apk/app-release.apk`

### Build Release App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

**Output**: `build/app/outputs/bundle/release/app-release.aab`

---

## Troubleshooting

### "Flutter command not found"
- Ensure Flutter is in your system PATH
- Restart your terminal/IDE after adding to PATH

### "Android SDK not found"
```bash
flutter config --android-sdk-path /path/to/android/sdk
```

### "Build failed: Hive adapters"
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub get
```

### "App crashes on startup"
```bash
flutter clean
flutter pub get
flutter run
```

### Gradle daemon issues
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

---

## Testing the Build

### On Real Device
```bash
# Connect device via USB
# Enable USB debugging

flutter run --release
```

### Check APK Size
```bash
ls -lh build/app/outputs/flutter-apk/app-release.apk
```

Expected size: ~50-60 MB

### Analyze APK
```bash
bundletool analyze-apk --bundle=build/app/outputs/flutter-apk/app-release.apk
```

---

## Installation on Device

### Using ADB (Android Debug Bridge)
```bash
# Install APK
adb install build/app/outputs/flutter-apk/app-release.apk

# Uninstall
adb uninstall com.habitflow.app

# View app info
adb shell dumpsys package com.habitflow.app
```

### Manual Installation
1. Transfer APK to device via USB
2. Open file manager
3. Tap APK file to install

---

## Code Quality

### Static Analysis
```bash
flutter analyze
```

### Format Code
```bash
dart format lib/
```

### Check Code Coverage
```bash
flutter test --coverage
```

---

## Distribution

### F-Droid (Recommended - FREE)
See `F-DROID_SUBMISSION.md` for detailed steps.

### GitHub Releases
```bash
# Create Git tag
git tag -a v1.0.0 -m "HabitFlow v1.0.0"
git push origin v1.0.0

# Upload APK via GitHub UI
# 1. Go to Releases
# 2. Create new release from tag
# 3. Attach APK file
```

### Direct Installation
Users can download APK from your website/repo and install directly.

---

## Development Workflow

### 1. **Create Feature Branch**
```bash
git checkout -b feature/new-feature
```

### 2. **Make Changes**
```bash
# Edit code
# Run tests
flutter test

# Analyze
flutter analyze
```

### 3. **Commit**
```bash
git add .
git commit -m "feat: add new feature"
```

### 4. **Push & Create PR**
```bash
git push origin feature/new-feature
```

### 5. **Merge & Release**
```bash
git checkout main
git merge feature/new-feature
git tag -a v1.1.0 -m "Release v1.1.0"
git push origin main --tags
```

---

## Build Performance Tips

1. **Use release builds** for distribution
2. **Clean before major changes**
   ```bash
   flutter clean
   ```
3. **Use `--verbose` for debugging**
   ```bash
   flutter run --verbose
   ```
4. **Enable multidex for large apps**
   - Already configured in `android/app/build.gradle`

---

## Useful Commands

```bash
# Check system setup
flutter doctor

# List connected devices
flutter devices

# Run specific device
flutter run -d <device_id>

# View app logs
flutter logs

# Hot reload (changes code live)
# Press 'r' in terminal

# Hot restart (full app restart)
# Press 'R' in terminal

# Stop app
# Press 'q' in terminal

# Generate app icons
flutter pub run flutter_launcher_icons:main

# Generate splash screen
flutter pub run flutter_native_splash:create

# Check package updates
flutter pub outdated
```

---

## Support

- **Flutter Docs**: https://flutter.dev/docs
- **Issue Tracker**: https://github.com/YOUR_USERNAME/HabitFlow/issues
- **Discussion Forum**: https://forum.f-droid.org

Happy building! 🚀
