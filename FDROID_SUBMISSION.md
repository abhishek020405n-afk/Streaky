# F-Droid Submission Guide for Streaky

## 📋 F-Droid Requirements Checklist

### ✅ F-Droid Prerequisites
- [ ] Open-source license (MIT, Apache 2.0, GPL, etc.)
- [ ] Source code on public GitHub repository
- [ ] No proprietary/non-free dependencies
- [ ] No tracking or analytics
- [ ] Privacy-focused (✅ You have this!)
- [ ] Proper documentation & README

### ⚠️ Issue to Fix: Google Mobile Ads
Your app includes `google_mobile_ads` dependency which is **proprietary and not allowed** on F-Droid.

**Solution:** Remove or make it optional:
```yaml
# Remove from pubspec.yaml:
  google_mobile_ads: ^5.1.0
```

F-Droid users prefer ad-free apps. For monetization, consider:
- Optional donations link
- Sponsorship mentions
- Patreon/Ko-fi integration

## 🚀 Step 1: Prepare Your GitHub Repository

### 1.1 Push Code to GitHub (if not already done)
```bash
git init
git add .
git commit -m "Initial commit: Streaky habit tracker"
git remote add origin https://github.com/YOUR_USERNAME/Streaky.git
git branch -M main
git push -u origin main
```

### 1.2 Add MIT License
Create `LICENSE` file in root:
```
MIT License

Copyright (c) 2024 Abhishek Kumar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
[Full MIT license text]
```

Or use: https://choosealicense.com/licenses/mit/

### 1.3 Update README.md
```markdown
# Streaky - Privacy-Focused Habit Tracker

A 100% FREE, privacy-focused habit & task tracker app with offline-first architecture.

## Features
- 📚 Track habits and tasks
- 🧘 Mindfulness & productivity tools
- 📊 Progress analytics
- 🔐 Complete privacy (no tracking)
- 💾 Offline-first (local database)
- ⚡ Performance optimized

## License
MIT License - See LICENSE file

## Building
```bash
flutter pub get
flutter build apk --release
```

## Contributors
- Abhishek Kumar
```

### 1.4 Add .gitignore for F-Droid friendly repo
Ensure your `.gitignore` includes:
```
build/
.dart_tool/
*.iml
.gradle/
local.properties
keystore.jks
keystore.properties
.DS_Store
.env
```

## 🔐 Step 2: Generate F-Droid Signing Key

F-Droid will rebuild your app with their signing key, but you still need a personal key:

```bash
# Generate signing key
keytool -genkey -v -keystore fdroid.jks ^
  -keyalg RSA -keysize 2048 -validity 10000 ^
  -alias streaky

# When prompted:
# Keystore password: YOUR_PASSWORD
# Key password: YOUR_PASSWORD (same)
```

Save in: `android/fdroid.jks`
Add to `.gitignore`: `*.jks`

## 📝 Step 3: Create F-Droid Metadata

F-Droid needs metadata. You'll provide this in your GitHub repo:

### 3.1 Create: `fastlane/metadata/android/en-US/`

This directory structure is what F-Droid reads:

```
fastlane/metadata/android/en-US/
├── full_description.txt
├── short_description.txt
├── title.txt
├── video.txt (optional)
└── images/
    ├── icon.png (512x512)
    ├── featureGraphic.png (1024x500)
    ├── phoneScreenshots/
    │   ├── 01.png
    │   ├── 02.png
    │   ├── 03.png
    │   └── 04.png
    └── tenInchScreenshots/
        ├── 01.png
        └── 02.png
```

### 3.2 File Contents:

**title.txt:**
```
Streaky
```

**short_description.txt:**
```
Privacy-focused habit & task tracker
```

**full_description.txt:**
```
Streaky is a 100% FREE, privacy-focused habit and task tracker with offline-first architecture.

Features:
• Track habits and daily tasks
• Build streaks and monitor progress
• Mindfulness & productivity tools
• Beautiful analytics & charts
• Completely private - no tracking, no ads
• Works offline - your data stays on your device
• Open source - MIT License

Why Streaky?
✓ Privacy First: No tracking, no analytics, no cloud storage
✓ Offline: All your data is stored locally on your device
✓ Free Forever: No ads, no premium features
✓ Open Source: Code is transparent and auditable
✓ Beautiful UI: Modern, intuitive design
✓ Lightweight: Fast and efficient

Perfect for building healthy habits and staying productive!

Source code: https://github.com/YOUR_USERNAME/Streaky
License: MIT
```

**video.txt (optional):**
```
# Leave empty or add YouTube link
```

## 📸 Step 4: Add Screenshots

Create these directories in your fastlane folder and add PNG files:

1. **phoneScreenshots/** (9:16 aspect ratio, e.g., 540x960)
   - 01.png - Home screen
   - 02.png - Habit creation
   - 03.png - Analytics
   - 04.png - Settings

2. **Icon** (512x512 PNG)
   - Copy your app icon to `fastlane/metadata/android/en-US/images/icon.png`

3. **Feature Graphic** (1024x500 PNG)
   - Marketing image showcasing the app

## 🔨 Step 5: Build Configuration

### 5.1 Update pubspec.yaml

Remove proprietary dependencies:
```yaml
# DELETE OR COMMENT OUT:
  # google_mobile_ads: ^5.1.0  # NOT ALLOWED ON F-DROID
```

### 5.2 Create F-Droid Build File

Create `android/app/build.gradle` configuration (already done, but verify):
- `minSdkVersion: 21`
- `targetSdkVersion: 34`
- Release signing enabled

## 📤 Step 6: Build Release APK

```bash
cd Streaky
flutter clean
flutter pub get

# Build APK (F-Droid will rebuild this)
flutter build apk --release

# Build App Bundle (preferred)
flutter build appbundle --release
```

Output: `build/app/outputs/apk/release/app-release.apk`

## 📋 Step 7: F-Droid Submission

### 7.1 Fork F-Droid Data Repository
1. Go to: https://github.com/f-droid/fdroiddata
2. Click **Fork** (top right)
3. Clone your fork:
```bash
git clone https://github.com/YOUR_USERNAME/fdroiddata.git
cd fdroiddata
```

### 7.2 Create Metadata YAML

F-Droid uses YAML for app metadata. Create:

`metadata/com.streaky.app.yml`

```yaml
Categories:
  - Productivity
License: MIT
AuthorName: Abhishek Kumar
WebSite: https://github.com/YOUR_USERNAME/Streaky
SourceCode: https://github.com/YOUR_USERNAME/Streaky
IssueTracker: https://github.com/YOUR_USERNAME/Streaky/issues

AutoName: Streaky
Description: |
  Streaky is a privacy-focused habit and task tracker with offline-first architecture.
  
  Features:
  • Track habits and daily tasks
  • Build streaks and monitor progress
  • Beautiful analytics and charts
  • Completely private - no tracking, no ads
  • Works offline - your data stays on your device

Builds:
  - versionName: 1.0.0
    versionCode: 1
    commit: v1.0.0
    gradle:
      - yes
    srclibs:
      - flutter@stable
    rm:
      - google_mobile_ads  # Remove proprietary deps
    prebuild:
      - echo 'flutter.sdk=/home/builder/tools/flutter' > local.properties
```

### 7.3 Submit Pull Request
1. Push your changes:
```bash
git add metadata/com.streaky.app.yml
git commit -m "Add Streaky app"
git push origin metadata
```

2. Create Pull Request on GitHub with title:
```
Add Streaky - Privacy-focused Habit Tracker
```

Include description:
```
App: Streaky
Package: com.streaky.app
Source: https://github.com/YOUR_USERNAME/Streaky
License: MIT

Privacy-focused habit and task tracker with offline-first architecture.
```

## ✅ Step 8: F-Droid Review Process

1. **Automated checks** (30 min - 2 hours): Tests your build
2. **Manual review** (1-3 days): F-Droid team reviews code
3. **Approval**: App appears on F-Droid

Time: Usually **3-5 days** total

## 🐛 Common F-Droid Issues & Fixes

### Issue: "Proprietary dependencies detected"
**Fix:** Remove `google_mobile_ads` from pubspec.yaml

### Issue: "Build fails"
**Fix:** Ensure your `build.gradle` is F-Droid compatible

### Issue: "No license file found"
**Fix:** Create LICENSE file with MIT/Apache/GPL license text

### Issue: "Privacy concerns"
**Fix:** Add privacy policy to README

## 📱 After Approval

Once approved:
1. App automatically builds on F-Droid's servers
2. Available on F-Droid app within 24 hours
3. Regular automatic updates when you tag releases
4. Each GitHub release tag triggers a new F-Droid build

### For Future Updates:
```bash
# Tag a release
git tag v1.0.1
git push origin v1.0.1

# Update version in pubspec.yaml & android/app/build.gradle
# Commit and push
# F-Droid will auto-build within 24 hours
```

## 🔗 Useful Links
- F-Droid Inclusion Process: https://f-droid.org/en/docs/Inclusion_How-To/
- F-Droid Repository: https://github.com/f-droid/fdroiddata
- Fastlane Metadata: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms/Android.md
- MIT License: https://choosealicense.com/licenses/mit/

## 💡 Tips
✓ Keep your GitHub README updated
✓ Tag releases with semantic versioning (v1.0.0, v1.0.1, etc.)
✓ Auto-updates work when F-Droid can detect releases
✓ Be responsive to F-Droid team questions during review
✓ Keep app lightweight for offline usage

Good luck! 🚀 F-Droid users will appreciate a privacy-focused habit tracker!
