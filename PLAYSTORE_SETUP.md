# Play Store Release Setup Guide for Streaky

## ✅ What's Been Done
- Android project structure initialized
- Gradle configuration files created
- Build signing configuration set up
- ProGuard rules for code protection added
- AndroidManifest.xml with required permissions

## 📋 Next Steps

### Step 1: Generate Signing Keystore
Generate a private keystore for signing your release APK:

```bash
keytool -genkey -v -keystore keystore.jks ^
  -keyalg RSA -keysize 2048 -validity 10000 ^
  -alias streaky-release-key
```

**When prompted, enter:**
- Password: Create a strong password (remember it!)
- Key password: Same as above
- Full Name: Your name or company
- Organizational Unit: Your company dept
- Organization: Your company name
- City/Locality: Your city
- State/Province: Your state
- Country Code: Your country (2 letters, e.g., IN, US)

Save the keystore file as: `android/keystore.jks`

### Step 2: Configure Keystore Properties
1. Copy the example file:
   ```bash
   copy android\keystore.properties.example android\keystore.properties
   ```

2. Edit `android/keystore.properties` and fill in:
   - `storePassword`: The password you set above
   - `keyPassword`: The password you set above
   - Keep `keyAlias` as: `streaky-release-key`

**⚠️ IMPORTANT:** Never commit `keystore.properties` to Git! It's already in `.gitignore`.

### Step 3: Update Android Configuration
Edit `android/local.properties` and update the Flutter SDK path:
```properties
flutter.sdk=C:\path\to\your\flutter\sdk
```

### Step 4: Build Release APK
```bash
cd Streaky
flutter build apk --release
```
Output: `build\app\outputs\apk\release\app-release.apk`

### Step 5: Build App Bundle (Recommended for Play Store)
```bash
flutter build appbundle --release
```
Output: `build\app\outputs\bundle\release\app-release.aab`

### Step 6: Create Google Play Developer Account
If you don't have one:
1. Go to [Google Play Console](https://play.google.com/console)
2. Pay $25 one-time registration fee
3. Accept Developer Agreement & Policies
4. Set up your developer account profile

### Step 7: Create App on Play Store
1. Open Google Play Console
2. Click "**Create app**"
3. Fill in:
   - **App name**: Streaky
   - **Default language**: English
   - **App or game**: App
   - **Free or paid**: Free
   - **Content rating**: Select appropriate category

### Step 8: Fill in App Details
Complete these sections:
- **Product details**: Description, category (productivity/lifestyle)
- **Graphics**: 
  - App icon (512x512 PNG)
  - Screenshots (up to 8, various sizes)
  - Feature graphic (1024x500 PNG)
  - Video (optional)
- **Content rating**: Fill questionnaire
- **Privacy policy**: Your privacy policy URL (required!)
- **Target audience**: Adults

### Step 9: Upload Release Build
1. Go to "**Testing**" → "**Internal testing**" (first time)
2. Upload your `app-release.aab` bundle
3. Test on internal devices
4. After 24-48 hours, promote to "**Production**"

### Step 10: Fill Content Rating Questionnaire
1. Go to "**Content rating**"
2. Complete IARC questionnaire
3. You'll get a rating (4+, 12+, 16+, or 18+)

### Step 11: Review and Submit
1. Go to "**Setup**" → "**Review questionnaire**"
2. Answer all policy questions
3. Ensure all sections are complete ✅
4. Click "**Submit for review**"

**Review takes 1-3 hours typically**, but can take up to 24 hours.

## 🔑 Important Files
- `android/keystore.jks` - Private signing key (NEVER share!)
- `android/keystore.properties` - Signing credentials (add to .gitignore)
- `android/local.properties` - Local Flutter SDK path
- `android/app/build.gradle` - Build configuration

## 🚨 Security Reminders
✋ **DO NOT:**
- Commit keystore.jks to Git
- Share keystore.properties with anyone
- Lose the keystore password (you'll need a new key for updates)

✅ **DO:**
- Keep backups of keystore.jks in a safe place
- Store the password securely
- Update version code for each release: `android/app/build.gradle` (versionCode: change from 1 → 2, 3, etc.)

## 🔄 Future Updates
For every update:
1. Increment `versionCode` in `android/app/build.gradle`
2. Update `versionName` (semantic versioning, e.g., 1.0.1)
3. Build new AAB: `flutter build appbundle --release`
4. Upload to Play Store internal testing first
5. Once tested, promote to production

## 📞 Support
If you need help with:
- Building: Use `flutter build appbundle -v` for verbose output
- Signing errors: Check keystore.properties matches your keystore
- Play Store issues: Check Play Console help or Google Play support

Good luck with your Play Store launch! 🚀
